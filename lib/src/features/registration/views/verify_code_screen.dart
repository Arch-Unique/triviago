import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:triviago/src/features/home/views/home_page.dart';
import 'package:triviago/src/features/registration/controllers/registration_controller.dart';
import 'package:triviago/src/global/services/http_service.dart';
import 'package:triviago/src/src_barrel.dart';

import '../../../global/ui/ui_barrel.dart';

class VerifyCodeScreen extends StatefulWidget {
  final Widget? nextScreen;
  const VerifyCodeScreen({this.nextScreen, Key? key}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.find<RegistrationController>();
  bool isVerifying = false;
  bool keepAlive = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: backAppBar(title: "triviago"),
      body: SizedBox(
        height: Ui.height(context),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Ui.padding(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Ui.boxHeight(8),
              Align(
                alignment: Alignment.center,
                child: AppText.medium("Account \nVerification",
                    fontSize: 28, alignment: TextAlign.center),
              ),
              Ui.boxHeight(56),
              OTPTextField(
                length: 4,
                controller: controller.otpController,
                width: Ui.width(context),
                fieldWidth: 40,
                style: const TextStyle(
                  fontSize: 24,
                  color: AppColors.primaryColor,
                ),
                otpFieldStyle: OtpFieldStyle(
                  borderColor: AppColors.primaryColor,
                  enabledBorderColor: AppColors.primaryColor,
                ),
                onChanged: (val) {},
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) async {
                  setState(() {
                    keepAlive = false;
                    isVerifying = true;
                  });
                  // if (widget.screen == null) {
                  //   Get.off(ForgotPasswordPage(
                  //     isFFP: false,
                  //     email: widget.email,
                  //     code: pin,
                  //   ));
                  // } else {
                  //   final c = await HttpService.validateotp(pin, widget.email);
                  //   if (c) {
                  //     Get.off(widget.screen);
                  //   }
                  // }
                  await Future.delayed(Duration(seconds: 2), () {});

                  controller.validateOTP();
                  setState(() {
                    isVerifying = false;
                  });
                  // if (c) {
                  Get.offAll(widget.nextScreen ?? HomeScreen());
                  // }
                },
              ),
              Ui.boxHeight(48),
              AppText.thin("Enter the 4 digit code that was sent to your email",
                  alignment: TextAlign.center),
              Ui.boxHeight(32),
              isVerifying ? buildProgress() : const SizedBox(),
              Ui.boxHeight(48),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () async {
                    controller.otpController.clear();
                    // final c = await HttpService.sendotp(widget.email);
                    setState(() {
                      isVerifying = false;
                    });
                    // if (c) {
                    //   Get.snackbar(
                    //     "Success",
                    //     "OTP sent to your email",
                    //     shouldIconPulse: true,
                    //     icon: const Icon(
                    //       Icons.check_circle_rounded,
                    //       color: Places.primaryColor,
                    //     ),
                    //     backgroundColor: Colors.white,
                    //     margin: const EdgeInsets.all(24),
                    //     duration: const Duration(seconds: 5),
                    //   );
                    // }
                  },
                  child: Text(
                    "Didn't receive the code ? \nResend OTP",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                        color: Colors.white),
                  ),
                ),
              ),
            ]),
          )),
        ),
      ),
    );
  }

  buildProgress() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        CircularProgress(
          54,
          primaryColor: Colors.white,
          secondaryColor: Colors.white10,
          strokeWidth: 10,
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          "Verifying...",
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => keepAlive;
}
