import 'package:flutter_fenxiao/common_utils/common_utils.dart';
import 'package:flutter_fenxiao/common_utils/local_storage.dart';
import 'package:flutter_fenxiao/models/user.dart';

import 'az_config.dart';

class AZGlobal {
  static NetEnvironment currentEnvironment = NetEnvironment.Dev;
  static String ip = "";
  static String token = "";
  //当前页面路由
  static String currentPage = "/";

  static saveCurrentPage(String name) {
    currentPage = name;
  }

  //退出登录
  static logout() {
    token = "";
  }

  ///修改当前网络环境
  static changeEnvironment(NetEnvironment type) {
    if (type != null) {
      currentEnvironment = type;
      LocalStorage.save(
          AZConfig.AZ_USER_ENVIRONMENT_KEY, CommonUtils.enumToString(type));
    }
  }

  ///设置当前抓包Ip
  static settingIpAddress(String ipAddress) {
    ip = ipAddress;
  }

  ///保存token
  static savaToken(String tokenT) {
    if (tokenT != null && tokenT.length != 0) {
      String usefulToken =
          tokenT.startsWith("Bearer ") ? tokenT : ("Bearer " + tokenT);
      LocalStorage.save(AZConfig.AZ_TOKEN_KEY, usefulToken);
      token = usefulToken;
    }
  }

  static User currentUser;
  static bool isLogin;
  static saveUserInfo(User user) {
    isLogin = user != null;
    currentUser = user;
  }
}
