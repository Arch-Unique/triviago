import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:triviago/src/features/home/views/home_page.dart';
import 'package:triviago/src/features/registration/views/verify_code_screen.dart';
import 'package:triviago/src/global/services/http_service.dart';
import 'package:triviago/src/src_barrel.dart';

class RegistrationController extends GetxController {
  /// TextEditingControllers
  /// 1 - Login Username
  /// 2 - Login Phone
  /// 3 - Login Image
  List<TextEditingController> textControllers =
      List.generate(3, (index) => TextEditingController());

  final formkey = GlobalKey<FormState>();
  final OtpFieldController otpController = OtpFieldController();

  final pformkey = GlobalKey<FormState>();

  login() async {
    final form = formkey.currentState!;
    if (form.validate()) {
      await HttpService.login(textControllers[0].value.text,
          textControllers[1].value.text, textControllers[2].value.text);
      UtilFunctions.clearTextEditingControllers(textControllers);
      Get.to(VerifyCodeScreen());
    }
  }

  validateOTP() {
    otpController.clear();
  }

  reset() {
    UtilFunctions.clearTextEditingControllers(textControllers);
    otpController.clear();
  }
}
