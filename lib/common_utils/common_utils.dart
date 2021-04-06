import 'dart:math';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class CommonUtils {
  //检查功能权限
  static Future<bool> _checkPermission(PermissionGroup permissionGroup) async {
    PermissionStatus status =
        await PermissionHandler().checkPermissionStatus(permissionGroup);
    return status == PermissionStatus.granted;
  }

  // 申请权限
  static Future<bool> requestPermission(PermissionGroup permissionGroup) async {
    bool hasPermission = await _checkPermission(permissionGroup);
    if (!hasPermission) {
      Map<PermissionGroup, PermissionStatus> map =
          await PermissionHandler().requestPermissions(<PermissionGroup>[
        permissionGroup // 在这里添加需要的权限
      ]);
      PermissionStatus permissionStatus = map[permissionGroup];
      if (PermissionStatus.granted != permissionStatus) {
        return false;
      }
    }
    return true;
  }

  ////========枚举处理，必须配套使用=======
  ///枚举转字符串
  static enumToString(o) => o.toString().split(".").last;

  ///字符转串枚举
  static T enumFromString<T>(Iterable<T> values, String value) {
    return values.firstWhere(
        (element) => element.toString().split(".").last == value,
        orElse: () => null);
  }

  ///计算图片缩放比例
  static double computeSize(int srcWidth, int srcHeight) {
    srcWidth = srcWidth % 2 == 1 ? srcWidth + 1 : srcWidth;
    srcHeight = srcHeight % 2 == 1 ? srcHeight + 1 : srcHeight;

    int longSide = max(srcWidth, srcHeight);
    int shortSide = min(srcWidth, srcHeight);

    double scale = shortSide / longSide;
    if (scale <= 1 && scale > 0.5625) {
      if (longSide < 1664) {
        return 1;
      } else if (longSide < 4990) {
        return 2;
      } else if (longSide > 4990 && longSide < 10240) {
        return 4;
      } else {
        return longSide / 1280 == 0 ? 1 : longSide / 1280;
      }
    } else if (scale <= 0.5625 && scale > 0.5) {
      return longSide / 1280 == 0 ? 1 : longSide / 1280;
    } else {
      return longSide / (1280.0 / scale);
    }
  }

  ///==========================保存图片到本地============================
  static Future<bool> saveImage(Uint8List pngBytes) async {
    bool saveSuccess = false;
    try {
      bool requestPermissionSuccess =
      await requestPermission(PermissionGroup.storage);
      if (!requestPermissionSuccess) {
        return false;
      }

      /// result 当Platform.isIOS result 返回值为bool
      /// 当Platform.isAndroid result 返回值为string  是保存的路径
      final result = await ImageGallerySaver.saveImage(pngBytes); //这个对象就是图片数据


      print("object");
      print(result);

      if (Platform.isIOS) {
        saveSuccess = result;
      } else {
        saveSuccess = (result != null && result != '');
      }

      return saveSuccess;
    } catch (e) {
      print(e);
      return false;
    }
  }

}
