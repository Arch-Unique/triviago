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
  final pgController = PageController(viewportFraction: 0.35);
  double _currentPage = 0.0;

  void userImageListener() {
    setState(() {
      _currentPage = pgController.page!;
    });
  }

  @override
  void initState() {
    pgController.addListener(userImageListener);
    super.initState();
  }

  @override
  void dispose() {
    pgController.removeListener(userImageListener);
    pgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Ui.padding(
            child: Form(
                key: controller.formkey,
                child: Column(children: [
                  MyLogo(),
                  Ui.boxHeight(24),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: PageView.builder(
                      controller: pgController,
                      clipBehavior: Clip.none,
                      itemBuilder: (_, i) {
                        final r = _currentPage - i;
                        final v = (-(r * r) + 1.5).clamp(0.0, 1.5);
                        final o = v.clamp(0.5, 1.0);
                        print("$_currentPage $r $v $o");
                        return Transform.scale(
                          // alignment: Alignment.bottomCenter,
                          scale: v,
                          child: Opacity(
                            opacity: o,
                            child: SvgPicture.asset(
                              Assets.usersImages[i],
                              height: 48,
                              width: 48,
                            ),
                          ),
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
                  Ui.boxHeight(24),
                  CustomTextField(
                      "Phone Number", "", controller.textControllers[1],
                      isLabel: false, varl: FPL.phone),
                  Ui.boxHeight(24),
                  FilledButton.white(() async {
                    await controller.login();
                  }, "SUBMIT"),
                ])),
          ),
        ),
      ),
    );
  }
}
