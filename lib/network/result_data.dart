class ResultData {
  var data;
  bool isSuccess;
  int code;
  var headers;
  String message;

  ResultData(this.data, this.isSuccess, this.code,
      {this.message, this.headers});
}
