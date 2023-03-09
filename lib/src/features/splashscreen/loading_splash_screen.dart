import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviago/src/global/ui/ui_barrel.dart';
import 'package:triviago/src/features/home/controllers/message_controller.dart';
import 'package:triviago/src/features/registration/controllers/registration_controller.dart';
import 'package:triviago/src/features/home/views/home_page.dart';
import 'package:triviago/src/features/registration/views/login_screen.dart';
import 'package:triviago/src/global/services/mypref.dart';

import '../../src_barrel.dart';

class LoadingSplashScreen extends StatefulWidget {
  const LoadingSplashScreen({super.key});

  @override
  State<LoadingSplashScreen> createState() => _LoadingSplashScreenState();
}

class _LoadingSplashScreenState extends State<LoadingSplashScreen> {
  injectDependencies() async {
    Get.put(RegistrationController());
    Get.put(MessageController());
    // Get.put(SettingsController());
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () async {
      if (mounted) {
        await injectDependencies();
        Widget hscreen = LoginScreen();
        final d = await MyPrefs.isLoggedIn();
        if (d) {
          hscreen = HomeScreen();
        } else {
          hscreen = LoginScreen();
        }
        Get.to(hscreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleAnimWidget(d: Duration(seconds: 1), child: MyLogo()),
      ),
    );
  }
}
