import '../network/url_path.dart';
import 'package:dio/dio.dart';
import '../extension/map_extension.dart';
import '../extension/list_extension.dart';

///日志拦截器
class DioLogInterceptor extends Interceptor {
  ///请求前
  @override
  Future onRequest(RequestOptions options) async {
    String requestStr = "\n==================== REQUEST ====================\n"
        "- URL:\n${options.baseUrl + options.path}\n"
        "- METHOD: ${options.method}\n";
    print(requestStr);
    requestStr = "- HEADER:\n${options.headers.mapToString()}\n";
    print(requestStr);
    final data = options.data;
    if (data != null) {
      if (data is Map)
        requestStr = "- DATA:\n${data.mapToString()}\n";
      else if (data is FormData) {
        final formDataMap = Map()
          ..addEntries(data.fields)
          ..addEntries(data.files);
        requestStr = "- BODY:\n${formDataMap.mapToString()}\n";
      } else
        requestStr = "- BODY:\n${data.toString()}\n";
    }
    print(requestStr);
    return options;
  }

  ///出错前
  @override
  Future onError(DioError err) async {
    String errorStr = "\n==================== RESPONSE ====================\n"
        "- URL:\n${err.request.baseUrl + err.request.path}\n"
        "- METHOD: ${err.request.method}\n";

    // errorStr += "- HEADER:\n${err.response.headers.map.mapToString()}\n";
    if (err.response != null && err.response.data != null) {
      print('╔ ${err.type.toString()}');
      errorStr += "- ERROR:\n${_parseResponse(err.response)}\n";
    } else {
      errorStr += "- ERRORTYPE: ${err.type}\n";
      errorStr += "- MSG: ${err.message}\n";
    }
    print(errorStr);
    return err;
  }

  ///响应前
  @override
  Future onResponse(Response response) async {
    String responseStr =
        "\n==================== RESPONSE ====================\n"
        "- URL:\n${response.request.uri}\n";
    responseStr += "- HEADER:\n{";
    response.headers.forEach(
        (key, list) => responseStr += "\n  " + "\"$key\" : \"$list\",");
    responseStr += "\n}\n";
    responseStr += "- STATUS: ${response.statusCode}\n";

    if (response.data != null) {
      responseStr += "- BODY:\n ${_parseResponse(response)}";
    }

    printWrapped(responseStr);

    return response;
  }

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  String _parseResponse(Response response) {
    String responseStr = "";
    var data = response.data;
    if (data is Map)
      responseStr += data.mapToString();
    else if (data is List)
      responseStr += data.listToString();
    else
      responseStr += response.data.toString();

    return responseStr;
  }
}
