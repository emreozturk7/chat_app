import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChangeProfileController extends GetxController {
  late TextEditingController emailCtrl;
  late TextEditingController nameCtrl;
  late TextEditingController statusCtrl;

  late ImagePicker imagePicker;

  XFile? pickedImage = null;

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadImage(String uid) async {
    Reference storageRef = storage.ref("$uid.png");
    File file = File(pickedImage!.path);

    try {
      await storageRef.putFile(file);
      final photoUrl = await storageRef.getDownloadURL();
      resetImage();
      return photoUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void resetImage() {
    pickedImage = null;
    update();
  }

  void selectImage() async {
    try {
      final checkDataImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (checkDataImage != null) {
        print(checkDataImage.name);
        print(checkDataImage.path);
        pickedImage = checkDataImage;
      }
      update();
    } catch (e) {
      print(e);
      pickedImage = null;
      update;
    }
  }

  @override
  void onInit() {
    emailCtrl = TextEditingController();
    nameCtrl = TextEditingController();
    statusCtrl = TextEditingController();
    imagePicker = ImagePicker();
    super.onInit();
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    nameCtrl.dispose();
    statusCtrl.dispose();
    super.onClose();
  }
}
