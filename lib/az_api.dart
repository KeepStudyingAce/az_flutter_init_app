import 'package:dio/dio.dart';
import 'package:flutter_fenxiao/common_config/az_global.dart';
import 'package:flutter_fenxiao/common_utils/common_utils.dart';
import 'package:flutter_fenxiao/common_utils/toast_util.dart';
import 'package:flutter_fenxiao/network/http_manager.dart';
import 'package:flutter_fenxiao/network/result_data.dart';
import 'package:flutter_fenxiao/network/url_path.dart';
import 'package:flutter_fenxiao/widgets/loading.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:multi_image_picker/multi_image_picker.dart';

class AZApi {
  /// 用户登陆 获取token
  // static Future<ResultData> accountLogin(Map<String, dynamic> params,
  //     {Function(dynamic) onSuccess, Function(String) onError}) async {
  //   return await HttpManager.getInstance().post(UrlPath.loginAccount,
  //       params: params, onSuccess: onSuccess, onError: onError);
  // }

  /*
  kind:(avatar)|(article)|(item)|(sku)|(logo)|(accountIdCard)|(invoice)|(item)|(spu)|(identity)|(license)|(refund)|(notice)|(edu)|(ugc)
  sourceId: 后端记录用,
  */
  //上传图片
  static Future<ResultData> uploadImage(String kind,
      {String sourceId,
      File file,
      ByteData byteData,
      Asset assetImage,
      bool compress = false,
      Function(dynamic) onSuccess,
      Function(String) onError}) async {
    try {
      MultipartFile multipartFile;
      if (assetImage != null) {
        //启用压缩 计算压缩比例
        double scale = CommonUtils.computeSize(
            assetImage.originalWidth, assetImage.originalHeight);

        ByteData byteData = await assetImage.getThumbByteData(
            (assetImage.originalWidth / scale).ceil(),
            (assetImage.originalHeight / scale).ceil(),
            quality: 60);

        if (byteData == null) {
          ToastUtil.showToast("该图片处理失败，请重新选择");
          return Future(() => null);
        }
        List<int> imageData = byteData.buffer.asUint8List();
        multipartFile = MultipartFile.fromBytes(
          imageData,
          filename: assetImage.name,
        );
      } else if (file != null) {
        String path = file.path;
        var name = path.substring(path.lastIndexOf("/") + 1, path.length);
        List<int> imageData = await file.readAsBytes();
        multipartFile = MultipartFile.fromBytes(
          imageData,
          filename: name,
        );
      } else if (byteData != null) {
        List<int> imageData = byteData.buffer.asUint8List();
        multipartFile = MultipartFile.fromBytes(
          imageData,
// 文件名
          filename: "${DateTime.now().millisecondsSinceEpoch.toString()}.png",
        );
      }

      FormData formData = FormData.fromMap({
// 后端接口的参数名称
        "file": multipartFile
      });

      return await HttpManager.getInstance().post(
        UrlPath.imageUpload,
        params: formData,
        queryParameters: {
          "kind": kind,
          "sourceId": sourceId ?? AZGlobal.currentUser.id
        },
        onSuccess: onSuccess,
        onError: onError,
      );
    } catch (e) {
      ToastUtil.showToast("该图片上传失败，请重试");
      return Future(() => null);
    }
  }

//批量上传图片
  static Future<ResultData> uploadImageList(List<Asset> imageList, String kind,
      {String sourceId,
      Function(dynamic) onSuccess,
      Function(String) onError}) async {
    try {
      List<MultipartFile> files = [];
      Loading.show();
      for (Asset assetImage in imageList) {
        /// 启用压缩 计算压缩比例
        double scale = CommonUtils.computeSize(
            assetImage.originalWidth, assetImage.originalHeight);

        ByteData byteData = await assetImage.getThumbByteData(
            (assetImage.originalWidth / scale).ceil(),
            (assetImage.originalHeight / scale).ceil(),
            quality: 80);

        if (byteData == null) {
          ToastUtil.showToast("该图片处理失败，请重新选择");
          return Future(() => null);
        }
        List<int> imageData = byteData.buffer.asUint8List();
        MultipartFile multipartFile = MultipartFile.fromBytes(
          imageData,
          filename: assetImage.name,
        );

        files.add(multipartFile);
      }

      List<MapEntry<String, MultipartFile>> entryList = [];

      for (int i = 0; i < files.length; i++) {
        print(files[i].length);
        entryList.add(MapEntry("files", files[i]));
      }

      FormData formData = FormData();
      formData.files.addAll(entryList);

      return await HttpManager.getInstance().post(
        UrlPath.imagesUpload,
        params: formData,
        queryParameters: {
          "kind": kind,
          "sourceId": sourceId ?? AZGlobal.currentUser.id
        },
        onSuccess: onSuccess,
        onError: onError,
      );
    } catch (e) {
      ToastUtil.showToast("图片上传失败，请重试");
      return Future(() => null);
    }
  }
}
