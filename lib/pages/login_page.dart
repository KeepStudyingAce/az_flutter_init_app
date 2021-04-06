import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/common_config/common_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_fenxiao/common_config/az_config.dart';
import 'package:flutter_fenxiao/common_utils/toast_util.dart';
import 'package:flutter_fenxiao/extension/string_extension.dart';

String logoIcon = "lib/sources/images/login_icon.png";
String textIcon = "lib/sources/images/login_text.png";
String lineBg = "lib/sources/images/login_line.png";

String accountIcon = "lib/sources/images/login_account.png";

String passwordIcon = "lib/sources/images/login_password.png";

String checkedIcon = "lib/sources/images/icon_checked.png";
String uncheckedIcon = "lib/sources/images/icon_unchecked.png";

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _telCl =
      new TextEditingController(text: "13208039565");
  final TextEditingController _pwdCl =
      new TextEditingController(text: "654321");
  final pagePadding = 25.0;
  final TextStyle hintStyle =
      TextStyle(fontSize: 14, color: CommonColors.black);
  bool agreePrivacy = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeColor,
      body: Stack(
        children: [
          SizedBox(
            height: AZConfig.screenHeight(),
          ),
          Container(
            width: AZConfig.screenWidth(),
            height: AZConfig.screenHeight() * 2 / 5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(lineBg),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Image.asset(logoIcon),
                Image.asset(textIcon),
              ],
            ),
          ),
          Positioned.fill(
            top: AZConfig.screenHeight() * 2 / 5 - 30.0,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  color: CommonColors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    _buildTel(),
                    SizedBox(height: 20),
                    _buildPwd(),
                    SizedBox(height: 20),
                    _buildButton(),
                    _buildBottomText(agreePrivacy ? checkedIcon : uncheckedIcon,
                        () {
                      setState(() {
                        agreePrivacy = !agreePrivacy;
                      });
                    }),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget _buildTel() {
    return Container(
      width: AZConfig.screenWidth() - pagePadding * 2,
      decoration: BoxDecoration(
        color: CommonColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: pagePadding),
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      child: Row(
        children: [
          Image.asset(
            accountIcon,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(10)),
              ),
              constraints: BoxConstraints(
                maxHeight: 50,
                minHeight: 50,
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  filled: true,
                  hintText: "请输入手机号",
                  hintStyle: hintStyle,
                  fillColor: CommonColors.transparent,
                  border: InputBorder.none,
                  counterText: "",
                ),
                onChanged: (text) {
                  print("输入手机号:$text");
                },
                controller: _telCl,
                keyboardType: TextInputType.number,
                maxLength: 11,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPwd() {
    return Container(
      width: AZConfig.screenWidth() - pagePadding * 2,
      decoration: BoxDecoration(
        color: CommonColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: pagePadding),
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      child: Row(
        children: [
          Image.asset(
            passwordIcon,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(10)),
              ),
              constraints: BoxConstraints(
                maxHeight: 50,
                minHeight: 50,
              ),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  filled: true,
                  hintText: "请输入密码",
                  hintStyle: hintStyle,
                  fillColor: CommonColors.transparent,
                  border: InputBorder.none,
                  counterText: "",
                ),
                onChanged: (text) {
                  print("输入密码:$text");
                },
                controller: _pwdCl,
                maxLength: 11,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButton() {
    return GestureDetector(
      onTap: () {
        if (!agreePrivacy) {
          ToastUtil.showToast("请先同意用户协议和隐私政策");
          return;
        }
        if (_telCl.text == "") {
          ToastUtil.showToast("手机号不能为空");
          return;
        }
        if (!_telCl.text.isMobileNumber()) {
          ToastUtil.showToast("请输入正确格式的手机号");
          return;
        }
        if (_pwdCl.text == "") {
          ToastUtil.showToast("密码不能为空");
          return;
        }
        //调用登陆接口
      },
      child: Container(
        height: 50,
        width: AZConfig.screenWidth() - 50,
        decoration: BoxDecoration(
          gradient: CommonColors.mainGradient,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          "登录",
          style: TextStyle(
              fontSize: 14,
              fontWeight: CommonFont.fontWeightBold,
              color: CommonColors.white),
        ),
      ),
    );
  }

  Widget _buildBottomText(
    String image,
    Function onCheck,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSwitcher(
            transitionBuilder: (child, anim) {
              return ScaleTransition(child: child, scale: anim);
            },
            duration: Duration(milliseconds: 300),
            child: IconButton(
              key: ValueKey(image),
              onPressed: onCheck,
              icon: Image.asset(image),
            )),
        RichText(
            text: TextSpan(
                text: "同意 ",
                style: TextStyle(
                    fontSize: CommonFont.normalTitleSize,
                    color: CommonColors.black),
                children: [
              TextSpan(
                  text: "用户协议",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("打开用户协议");
                    },
                  style: TextStyle(
                    fontSize: CommonFont.normalTitleSize,
                    color: CommonColors.themeColor,
                  )),
              TextSpan(
                text: " 和 ",
              ),
              TextSpan(
                  text: "隐私政策",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("打开隐私政策");
                    },
                  style: TextStyle(
                    fontSize: CommonFont.normalTitleSize,
                    color: CommonColors.themeColor,
                  )),
            ]))
      ],
    );
  }
}
