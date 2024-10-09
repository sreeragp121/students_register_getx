import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddImageController extends GetxController {
  var image = ''.obs;

  Future pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image.value = pickedImage.path;
    }
  }

  Future pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image.value = pickedImage.path;
    }
  }

  bool imageValidate() {
    if (image.value.isEmpty) {
      Get.snackbar(
        'No Image',
        'Please select an image',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }
}
