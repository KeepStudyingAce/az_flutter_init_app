import 'package:flutter_fenxiao/common_config/az_global.dart';
import 'package:flutter_fenxiao/routers/app_router.dart';
import 'package:flutter_fenxiao/routers/application.dart';

import '../network/code.dart';
import 'package:dio/dio.dart';
import 'result_data.dart';

/// 数据初步处理
class ResponseInterceptors extends InterceptorsWrapper {
  bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        int code = response.data["code"];
        String message = response.data["message"];
        if (code == 1) {
          return new ResultData(response.data["data"], true, Code.CODE_SUCCESS,
              headers: response.headers, message: message);
        }
        if (code == 0) {
          return new ResultData(response.data["data"], false, Code.CODE_FAILED,
              headers: response.headers, message: message);
        }

        if (code == 401) {
          // /token失效，跳转登录页面
          if (!AZGlobal.currentPage.startsWith(AppRouter.loginPage)) {
            AppRouter.goLoginPage(Application.navigatorKey.currentContext);
          }
        }
      } else {
        ///请求返回其他情况 505，404等
        return new ResultData(
            response.data["data"], false, response.data["code"],
            headers: response.headers, message: response.statusMessage);
      }
    } catch (e) {
      print("ResponseError====" + e.toString() + "****" + option.path);

      return new ResultData(response.data["data"], false, response.statusCode,
          headers: response.headers, message: response.statusMessage);
    }

    return new ResultData(response.data["data"], false, response.statusCode,
        headers: response.headers, message: response.data["message"]);
  }
}
