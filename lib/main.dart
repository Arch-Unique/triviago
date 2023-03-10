import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:triviago/src/app/theme/colors.dart';
import 'package:triviago/src/features/splashscreen/loading_splash_screen.dart';
import 'package:triviago/src/utils/constants/constant_barrel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  print("start");
  WidgetsFlutterBinding.ensureInitialized();

  print("ensured");
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // injectDependencies();

    return GetMaterialApp(
        title: 'triviago',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'GB'), // English
        ],
        theme: ThemeData(
            fontFamily: Assets.appFontFamily,
            primarySwatch: AppColors.primaryColor,
            scaffoldBackgroundColor: AppColors.black,
            textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColors.white,
                selectionColor: AppColors.white,
                selectionHandleColor: AppColors.white)),
        home: LoadingSplashScreen());
  }
}
