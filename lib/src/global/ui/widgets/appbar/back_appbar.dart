import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '/src/app/app_barrel.dart';
import '/src/global/ui/ui_barrel.dart';

AppBar backAppBar({String? title, Color color = AppColors.primaryColor}) {
  return AppBar(
      backgroundColor: Colors.transparent,
      title: title == null
          ? null
          : AppText.bold(title, fontSize: 32, color: color),
      elevation: 0,
      centerTitle: true,
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(IconlyLight.arrow_left_2),
        );
      }));
}
