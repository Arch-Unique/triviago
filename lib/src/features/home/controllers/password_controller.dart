import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:triviago/src/features/registration/views/login_screen.dart';
import 'package:triviago/src/global/ui/ui_barrel.dart';
import 'package:triviago/src/src_barrel.dart';

class PasswordController extends GetxController {
  List<TextEditingController> textEditingController =
      List.generate(2, (index) => TextEditingController());
  final formKey = GlobalKey<FormState>();

  final OtpFieldController otpController = OtpFieldController();
  RxInt currentScreen = 0.obs;

  resetPassword() {
    final form = formKey.currentState!;
    if (form.validate()) {
      //show something

      Ui.showSnackBar("Password Successfuly changed", isError: false);
      Get.offAll(LoginScreen());
    }
  }

  changeScreen() {
    currentScreen.value = 1;
  }

  previousScreen() {
    for (var element in textEditingController) {
      element.clear();
    }
  }

  reset() {
    currentScreen.value = 0;
    UtilFunctions.clearTextEditingControllers(textEditingController);
    otpController.clear();
  }
}
