import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/common_config/common_style.dart';
import 'package:flutter_fenxiao/common_utils/toast_util.dart';
import 'package:flutter_fenxiao/routers/navigator_util.dart';
import 'package:flutter_fenxiao/widgets/loading.dart';

import 'package:webview_flutter/webview_flutter.dart';

//独立的webViewPage
class WebViewPage extends StatefulWidget {
  final String title;
  final String url;
  WebViewPage({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final backIcon = "lib/sources/images/icon_back.png";
  @override
  void initState() {
    super.initState();
    Loading.show();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: CommonColors.white,
        elevation: 0.0,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
            color: CommonColors.black,
            fontWeight: CommonFont.fontWeightMiddle,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            NavigatorUtil.pop(context);
          },
          child: Image.asset(backIcon),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: WebView(
          initialUrl: widget.url,
          //JS执行模式 是否允许JS执行
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            Loading.dismiss();
          },
          onWebResourceError: (error) {
            Loading.dismiss();
            ToastUtil.showToast("页面加载失败，请重试");
          },
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }
}
