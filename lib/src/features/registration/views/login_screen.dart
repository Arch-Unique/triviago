import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:triviago/src/features/registration/controllers/registration_controller.dart';
import 'package:triviago/src/global/ui/ui_barrel.dart';
import 'package:triviago/src/global/ui/widgets/fields/custom_textfield.dart';

import '../../../src_barrel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Ui.padding(
            child: Form(
              key: controller.formkey,
              child: Obx(() {
                return Column(children: [
                  MyLogo(),
                  Ui.boxHeight(24),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: PageView.builder(
                      itemBuilder: (_, i) {
                        return SvgPicture.asset(
                          Assets.usersImages[i],
                          height: 48,
                          width: 48,
                        );
                      },
                      onPageChanged: (i) {
                        controller.textControllers[2].text = i.toString();
                      },
                      itemCount: Assets.usersImages.length,
                    ),
                  ),
                  Ui.boxHeight(24),
                  CustomTextField("Username", "", controller.textControllers[0],
                      isLabel: false, varl: FPL.text),
                  CustomTextField(
                      "Phone Number", "", controller.textControllers[1],
                      isLabel: false, varl: FPL.phone),
                  Ui.boxHeight(24),
                  FilledButton.white(() async {
                    await controller.login();
                  }, "SUBMIT"),
                ]);
              }),
            ),
          ),
        ),
      ),
    );
  }
}
