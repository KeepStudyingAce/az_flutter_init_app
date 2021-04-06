import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_alert/easy_alert.dart';
import 'package:flutter_fenxiao/common_config/common_style.dart';
import 'package:flutter_fenxiao/common_config/az_config.dart';
import 'package:flutter_fenxiao/routers/application.dart';
import 'package:flutter_fenxiao/routers/navigator_util.dart';

class ToastUtil {
  static showToast(String message) {
    // Loading.showToast(message);
    Alert.toast(Application.navigatorKey.currentContext, message,
        position: ToastPosition.center, duration: ToastDuration.short);
  }

  static showAlert(
    BuildContext context,
    String title,
    String content, {
    String cancelText = "取消",
    String okText = "确定",
    Function() okCallback,
  }) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (c) {
          return Center(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                width: AZConfig.screenWidth() - 50,
                height: 150,
                margin: EdgeInsets.fromLTRB(25, 0, 25, 140),
                decoration: BoxDecoration(
                  color: CommonColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        decoration: TextDecoration.none,
                        fontWeight: CommonFont.fontWeightMiddle,
                        color: CommonColors.black,
                      ),
                    ),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 17,
                        decoration: TextDecoration.none,
                        fontWeight: CommonFont.fontWeightMiddle,
                        color: CommonColors.black,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Divider(
                      height: 0.5,
                      color: CommonColors.separatorColor,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: (AZConfig.screenWidth() - 50) / 2 - 0.5,
                            height: 55,
                            decoration: BoxDecoration(
                                border: Border(
                              right: BorderSide(
                                width: 0.5,
                                color: CommonColors.separatorColor,
                              ),
                            )),
                            alignment: Alignment.center,
                            child: Text(
                              cancelText,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 17,
                                color: CommonColors.black,
                                fontWeight: CommonFont.fontWeightMiddle,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            okCallback?.call();
                          },
                          behavior: HitTestBehavior.opaque,
                          child: SizedBox(
                            width: (AZConfig.screenWidth() - 50) / 2,
                            height: 55,
                            child: Center(
                              child: Text(
                                okText,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 17,
                                  color: CommonColors.themeColor,
                                  fontWeight: CommonFont.fontWeightMiddle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static showInput(
    BuildContext context,
    String title,
    Function(String) callback, {
    String value,
    String hintText,
  }) {
    TextEditingController controller = new TextEditingController.fromValue(
        TextEditingValue(
            text: value ?? "",
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: (value ?? "").length))));
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (c) {
          return Center(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                width: AZConfig.screenWidth() - 50,
                height: 210,
                margin: EdgeInsets.fromLTRB(25, 0, 25, 140),
                decoration: BoxDecoration(
                  color: CommonColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        decoration: TextDecoration.none,
                        fontWeight: CommonFont.fontWeightMiddle,
                        color: CommonColors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      height: 50,
                      width: AZConfig.screenWidth() - 50 - 24,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: CommonColors.separatorColor, width: 0.5),
                        ),
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.none,
                          color: CommonColors.black,
                        ),
                        maxLines: 3,
                        controller: controller,
                        cursorColor: CommonColors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hintText ?? title,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            color: CommonColors.black,
                          ),
                          filled: true,
                          fillColor: CommonColors.white,
                        ),
                        autofocus: true,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Divider(
                      height: 0.5,
                      color: CommonColors.separatorColor,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: (AZConfig.screenWidth() - 50) / 2 - 0.5,
                            height: 55,
                            decoration: BoxDecoration(
                                border: Border(
                              right: BorderSide(
                                width: 0.5,
                                color: CommonColors.separatorColor,
                              ),
                            )),
                            alignment: Alignment.center,
                            child: Text(
                              "取消",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 17,
                                color: CommonColors.black,
                                fontWeight: CommonFont.fontWeightMiddle,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            callback(controller.text);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: SizedBox(
                            width: (AZConfig.screenWidth() - 50) / 2,
                            height: 55,
                            child: Center(
                              child: Text(
                                "确定",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 17,
                                  color: CommonColors.themeColor,
                                  fontWeight: CommonFont.fontWeightMiddle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
