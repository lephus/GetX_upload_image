import 'dart:io';

import 'package:get/get.dart';

class ImageUploadProvider extends GetConnect {
  // upload Image
  Future<String> uploadImage(File file) async
  {
    try
    {
      final form = FormData(
        {
          'file':MultipartFile(file, filename: 'phu.jpg')
        }
      );
      final response = await post("http://192.168.1.9:5000/upload-image", form);
      if (response.status.hasError){
        return Future.error(response.body);
      }else{
        return response.body['image'];
      }
    }
    catch(e)
    {
      return Future.error(e.toString());
    }
  }
}
