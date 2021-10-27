import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateStatusController extends GetxController {
  late TextEditingController statusCtrl;

  @override
  void onInit() {
    statusCtrl = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    statusCtrl.dispose();
    super.onClose();
  }
}
