import 'package:flutter/material.dart';
import 'package:foodplanner_app/ui/widgets/loader_container.dart';
import 'package:get/get.dart';

class Utils {
  static showLoader(message) {
    Get.dialog(LoaderContainer(
      message: message,
    ));
  }

  static closeLoader() {
    Get.back();
  }

  static successSnackbar(String message) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Colors.green.shade400,
      title: "Success!",
      message: message,
      duration: Duration(milliseconds: 1500),
    ));
  }

  static errorSnackbar(String message) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Colors.red.shade400,
      title: "Error",
      message: message,
      duration: Duration(milliseconds: 1500),
    ));
  }
}
