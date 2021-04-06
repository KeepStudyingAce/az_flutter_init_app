import 'dart:io';
import 'dart:typed_data';

import '../common_config/az_config.dart';
import '../common_config/az_global.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import '../widgets/loading.dart';
import 'code.dart';
import 'dio_log_interceptor.dart';
import 'response_interceptor.dart';
import 'result_data.dart';
import 'url_path.dart';

const iosAppId = "b9d73133-d70f-423b-9ed6-e1d4e4215494";
const androidAppId = "74e57358-c3bb-4614-b90d-538a46d49f71";

class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio _dio;

  static const CONNECT_TIMEOUT = 10000;

  static CancelToken cancelToken = new CancelToken();

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal() {
    if (null == _dio) {
      _dio = new Dio(new BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: CONNECT_TIMEOUT,
      ));
      _dio.interceptors.add(new DioLogInterceptor());
      _dio.interceptors.add(new ResponseInterceptors());
    }
  }

  static HttpManager getInstance({String url}) {
    return _instance._baseUrl(url);
  }

  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      String url = "";
      if (baseUrl != null) {
        url = baseUrl;
      } else {
        switch (AZGlobal.currentEnvironment) {
          case NetEnvironment.Dev:
            url = UrlPath.devBaseUrl;
            break;
          case NetEnvironment.Test:
            url = UrlPath.testBaseUrl;
            break;
          case NetEnvironment.Release:
            url = UrlPath.releaseBaseUrl;
            break;
          default:
            url = UrlPath.devBaseUrl;
        }
      }
      _dio.options.baseUrl = url;

      ///支持代理
      if (AZGlobal.ip != null && AZGlobal.ip.isNotEmpty) {
        print("=====AZGlobal.ip:==${AZGlobal.ip}=================");
        (_dio.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (client) {
          //这一段是解决安卓https抓包的问题
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            return Platform.isAndroid;
          };
          print("当前地址：$url");
          print("抓包IP：${AZGlobal.ip}");
          //这是抓包代理
          client.findProxy = (uri) {
            return "PROXY ${AZGlobal.ip}";
          };
        };
      }
    }
    return this;
  }

  ///通用的GET请求
  Future<ResultData> get(api,
      {String param,
      params,
      withLoading = true,
      Function(dynamic) onSuccess,
      Function(String) onError}) async {
    if (withLoading) {
      Loading.show();
    }
    checkNetwork();

    /// 拼接路径
    if (param != null && param.isNotEmpty) {
      api = api + "/" + param;
    }

    Response response;

    try {
      response = await _dio.get(
        api,
        queryParameters: params,
        options: Options(headers: buildHeader()),
        cancelToken: cancelToken,
      );
      if (withLoading) {
        Loading.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
        Loading.dismiss();
      }
      onError?.call(resultError(e).message);
      return resultError(e);
    }

    if (response.data is DioError) {
      onError?.call(response.data['message'] ?? response.data.toString());
      return resultError(response.data['code']);
    }
    ResultData result = response.data as ResultData;
    if (result.isSuccess) {
      onSuccess?.call(result.data);
    } else {
      onError?.call(result.message);
    }
    return response.data as ResultData;
  }

  ///通用的POST请求
  Future<ResultData> post(api,
      {String param,
      params,
      withLoading = true,
      Map<String, dynamic> queryParameters,
      Function(dynamic) onSuccess,
      Function(String) onError}) async {
    if (withLoading) {
      Loading.show();
    }
    checkNetwork();

    /// 拼接路径
    if (param != null && param.isNotEmpty) {
      api = api + "/" + param;
    }

    Response response;
    try {
      response = await _dio.post(
        api,
        data: params,
        queryParameters: queryParameters,
        options: Options(
            headers: buildHeader(),
            contentType: queryParameters != null
                ? "multipart/form-data"
                : "application/json"),
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      if (withLoading) {
        Loading.dismiss();
      }

      onError?.call(resultError(e).message);
      return resultError(e);
    }
    if (withLoading) {
      Loading.dismiss();
    }

    if (response.data is DioError) {
      onError?.call(response.data['message'] ?? response.data.toString());
      return resultError(response.data['code']);
    }
    ResultData result = response.data as ResultData;
    if (result.isSuccess) {
      onSuccess?.call(result.data);
    } else {
      onError?.call(result.message);
    }

    return result;
  }

  Map<String, String> buildHeader() {
    Map<String, String> header = {};
    header["TimeZone"] =
        (DateTime.now().timeZoneOffset.inMinutes / 60.0).toString();
    header["platform"] = Platform.isIOS ? "ios" : "android";

    print("当前Token：${AZGlobal.token}");
    header["Authorization-worker"] = AZGlobal.token;
    header["app-id"] = Platform.isIOS ? iosAppId : androidAppId;

    return header;
  }

  ///通用的DELETE请求  单独删除目前是将主键直接拼接在api 路径上
  /// 如api/front/order/address/deleteAddress/11
  /// 古单个删除 拼接在路径后的使用 param
  /// 多个入参请使用params入参
  Future<ResultData> delete(String api,
      {String param,
      dynamic params,
      withLoading = true,
      Function(dynamic) onSuccess,
      Function(String) onError}) async {
    if (withLoading) {
      Loading.show();
    }
    checkNetwork();

    /// 拼接路径
    if (param != null && param.isNotEmpty) {
      api = api + "/" + param;
    }

    Response response;
    try {
      response = await _dio.delete(
        api,
        data: params,
        options: Options(headers: buildHeader()),
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      if (withLoading) {
        Loading.dismiss();
      }
      onError?.call(resultError(e).message);
      return resultError(e);
    }
    if (withLoading) {
      Loading.dismiss();
    }

    if (response.data is DioError) {
      onError?.call(response.data['message'] ?? response.data.toString());
      return resultError(response.data['code']);
    }
    ResultData result = response.data as ResultData;
    if (result.isSuccess) {
      onSuccess?.call(result.data);
    } else {
      onError?.call(result.message);
    }

    return result;
  }

  ///通用的PUT请求
  Future<ResultData> put(String api,
      {params,
      String param,
      withLoading = true,
      Function(dynamic) onSuccess,
      Function(String) onError}) async {
    if (withLoading) {
      Loading.show();
    }
    checkNetwork();

    /// 拼接路径
    if (param != null && param.isNotEmpty) {
      api = api + "/" + param;
    }

    Response response;
    try {
      response = await _dio.put(
        api,
        data: params,
        options: Options(headers: buildHeader()),
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      if (withLoading) {
        Loading.dismiss();
      }
      onError?.call(resultError(e).message);
      return resultError(e);
    }
    if (withLoading) {
      Loading.dismiss();
    }

    if (response.data is DioError) {
      onError?.call(response.data['message'] ?? response.data.toString());
      return resultError(response.data['code']);
    }
    ResultData result = response.data as ResultData;
    if (result.isSuccess) {
      onSuccess?.call(result.data);
    } else {
      onError?.call(result.message);
    }

    return result;
  }

  ///通用的PATCH请求
  Future<ResultData> patch(String api,
      {params,
      String param,
      withLoading = true,
      Function(dynamic) onSuccess,
      Function(String) onError}) async {
    if (withLoading) {
      Loading.show();
    }
    checkNetwork();

    /// 拼接路径
    if (param != null && param.isNotEmpty) {
      api = api + "/" + param;
    }

    Response response;
    try {
      response = await _dio.patch(
        api,
        data: params,
        options: Options(headers: buildHeader()),
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      if (withLoading) {
        Loading.dismiss();
      }
      onError?.call(resultError(e).message);
      return resultError(e);
    }
    if (withLoading) {
      Loading.dismiss();
    }

    if (response.data is DioError) {
      onError?.call(response.data['message'] ?? response.data.toString());
      return resultError(response.data['code']);
    }
    ResultData result = response.data as ResultData;
    if (result.isSuccess) {
      onSuccess?.call(result.data);
    } else {
      onError?.call(result.message);
    }

    return result;
  }

  //===================================下载图片=======================================
  ///通用的GET请求
  Future<Uint8List> getImage(String url,
      {withLoading = true,
      Function(Uint8List) onSuccess,
      Function(String) onError}) async {
    Response response;
    try {
      response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: CONNECT_TIMEOUT,
          sendTimeout: CONNECT_TIMEOUT,
        ),
      );
    } on DioError catch (e) {
      onError?.call(e.message ?? e.toString());
      return [] as Uint8List;
    }

    if (response.data is DioError) {
      onError?.call(response.data['message'] ?? response.data.toString());
      return [] as Uint8List;
    }
    Uint8List result = response.data as Uint8List;
    if (result != null) {
      onSuccess?.call(result);
    }
    return response.data as Uint8List;
  }

  void checkNetwork() async {
    // ConnectivityResult result;
    // try {
    //   result = await Connectivity().checkConnectivity();
    // } on PlatformException catch (e) {
    //   print(e.toString());
    //   return Future(() => false);
    // }
    // switch (result) {
    //   case ConnectivityResult.wifi:
    //   case ConnectivityResult.mobile:
    //     Provider.of<AppProvider>(Application.navigatorKey.currentContext,
    //             listen: false)
    //         .saveNetConnectStatus(true);
    //     break;
    //   case ConnectivityResult.none:
    //   default:
    //     Provider.of<AppProvider>(Application.navigatorKey.currentContext,
    //             listen: false)
    //         .saveNetConnectStatus(false);
    //     break;
    // }
  }

  //取消当前请求
  static void cancelRequests({CancelToken token}) {
    if (token == null) {
      token = cancelToken;
    }
    token.cancel("cancelled");
  }
}

ResultData resultError(DioError e) {
  Response errorResponse;
  if (e.response != null) {
    errorResponse = e.response;
  } else {
    errorResponse = new Response(statusCode: 666);
  }
  if (e.type == DioErrorType.CONNECT_TIMEOUT ||
      e.type == DioErrorType.RECEIVE_TIMEOUT) {
    errorResponse.statusCode = Code.NETWORK_TIMEOUT;
    return new ResultData(
        errorResponse.statusMessage, false, errorResponse.statusCode,
        message: "网络请求超时");
  }
  return new ResultData(
      errorResponse.statusMessage, false, errorResponse.statusCode,
      message: "网络链接失败");
}
