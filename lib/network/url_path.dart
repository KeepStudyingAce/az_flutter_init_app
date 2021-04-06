class UrlPath {
  /*
  三个环境：
  dev： http://d-java.myazstore.com/
*/
  static const String devBaseUrl =
      "http://d-java.myazstore.com/"; //192.168.11.*.8090 164：大哥，29:兴晨
  static const String testBaseUrl = "http://t-java.myazstore.com/";
  static const String releaseBaseUrl = "https://java1.myazstore.com/";

  ///上传图片
  static String imageUpload = "api/front/daemon/files/upload"; //上传单张图片
  static String imagesUpload = "api/front/daemon/files/uploadFiles"; //批量上传

}
