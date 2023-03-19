import 'package:flutter/material.dart';
import 'package:foodplanner_app/backend/model/user.dart';
import 'package:foodplanner_app/main.dart';
import 'package:foodplanner_app/utils/utils.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();
  var user = Rxn<User>();

  login(String email, String password) {
    if (email.isEmpty || !email.isEmail) {
      Utils.errorSnackbar("Please enter valid email");
      return false;
    }
    User? user = vm.findByEmail(email);
    if (user == null) {
      Utils.errorSnackbar("User not found in our database. Please sign up");
      return false;
    }
    //when user is found with wrong pass
    if (!user.login(password)) {
      Utils.errorSnackbar("Wrong password. Try again");
      return false;
    }
    //user found and logged in
    Utils.successSnackbar("Login successful");
    return true;
  }

  signUp(String name, String email, String password) {
    if (name.isEmpty) {
      Utils.errorSnackbar("Please enter username");
      return false;
    }
    if (email.isEmpty || !email.isEmail) {
      Utils.errorSnackbar("Please enter valid email");
      return false;
    }
    if (password.isEmpty) {
      Utils.errorSnackbar("Please enter password");
      return false;
    }
    User? user = vm.findByEmail(email);
    if (user != null) {
      Utils.errorSnackbar("User with this account already exist, login");
      return false;
    }
    if (vm.signUpUser(name, email, password) < 1) {
      Utils.errorSnackbar("User not registered, please try again");
      return false;
    }
    //user created account
    Utils.successSnackbar("Sign up successful");
    return true;
  }
}
