import 'package:flutter/services.dart';

/// flutter向原生传递是函数名
class AZEventName {
  ///获取文件路径
  static const String getAbsolutePath = "getAbsolutePath";
}

/// 通信channel名称
class AZMethodChannel {
  /// Flutter向native传递事件
  static const nativeChannel = const MethodChannel('com.azgo.flutter/native');

  /// native向flutter传递事件
  static const flutterChannel = const MethodChannel('com.azgo.flutter/flutter');
}
