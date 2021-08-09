import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Upload image'),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(()=>controller.selectedImagePart.value == "" ? Text("No file image selected") : Image.file(File(controller.selectedImagePart.value))
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                  child: Text("Camera"),
                  onPressed: (){
                    controller.getImage(ImageSource.camera);
                  }
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                  child: Text("Gallery"),
                  onPressed: (){
                    controller.getImage(ImageSource.gallery);
                  }
              )
            ],
          ),
        ),
      )
    );
  }
}
