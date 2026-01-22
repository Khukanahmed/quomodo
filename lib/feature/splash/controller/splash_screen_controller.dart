import 'dart:async';

import 'package:get/get.dart';
import 'package:quomodo/core/nav_bar/view/nav_bar.dart';

class SplashScreenController extends GetxController {
  void checkIsLogin() async {
    Timer(const Duration(seconds: 2), () async {
      Get.offAll(() => MainScreen());
    });
  }

  @override
  void onInit() {
    super.onInit();
    checkIsLogin();
  }
}
