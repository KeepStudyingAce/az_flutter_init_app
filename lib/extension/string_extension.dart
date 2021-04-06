/// 字符串扩展方法
extension StringExtension on String {
  /// 是否是电话号码
  bool isMobileNumber() {
    if (this?.isNotEmpty != true) return false;

    return RegExp(r'(^[0]{0,1}4\d{8}$)|(^[0]{0,1}2\d{7,9}$)|(^1[3-9]\d{9}$)')
        .hasMatch(this);
  }

  /// 是否是密码
  bool isPassword() {
    if (this?.isNotEmpty != true) return false;
    return this.length > 4;
  }

  /// 是否是验证码
  bool isMsgCode() {
    if (this?.isNotEmpty != true) return false;
    return this.length > 4;
  }
}
