import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:getx_upload_image/app/modules/home/providers/image_upload_provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  var selectedImagePart = ''.obs;
  var selectedImageSize = ''.obs;

  //crop code
  var cropImagePart = "".obs;
  var cropImageSize = "".obs;

  // compress code
  var compressImagePart = "".obs;
  var compressImageSize = "".obs;

  void getImage(ImageSource imageSource) async
  {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null)
      {
        selectedImagePart.value = pickedFile.path;
        selectedImageSize.value = ((File(selectedImagePart.value)).lengthSync()/1024/1024).toStringAsFixed(2)+" Mb";

        // crop
        final cropImageFile  = await ImageCropper.cropImage(
          sourcePath: selectedImagePart.value,
          maxWidth: 512,
          maxHeight: 512,
          compressFormat: ImageCompressFormat.jpg
        );
        cropImagePart.value = cropImageFile.path;
        cropImageSize.value =  ((File(cropImagePart.value)).lengthSync()/1024/1024).toStringAsFixed(2)+" Mb";
        final dir = await Directory.systemTemp;
        final targetPath = dir.absolute.path + "temp.jpg";
        var compressedFile = await FlutterImageCompress.compressAndGetFile(cropImagePart.value, targetPath, quality: 90);
        compressImagePart.value = compressedFile.path;
        compressImageSize.value =  ((File(compressImagePart.value)).lengthSync()/1024/1024).toStringAsFixed(2)+" Mb";
        uploadImage(compressedFile);
      }
    else
      {
        Get.snackbar("Error", "No image selected",
        snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
        );
      }
  }

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  void uploadImage(File file)
  {
    Get.dialog(Center(child: CircularProgressIndicator(),),
      barrierDismissible: false,
    );
    ImageUploadProvider().uploadImage(file).then((resp){
      Get.back();
      Get.snackbar("Upload Successfullty", "$resp",
      snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white
      );
    },onError: (err){
      Get.back();
      Get.snackbar("Upload fail", "Can not upload image",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    }
    );
  }
}
