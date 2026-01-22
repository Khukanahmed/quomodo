import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quomodo/core/const/app_colors.dart';
import 'package:quomodo/core/const/app_sizes.dart';
import 'package:quomodo/core/route/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return GetMaterialApp(
      title: 'Quomodo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBgColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),

      fallbackLocale: Locale("en", "US"),

      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      builder: EasyLoading.init(),
    );
  }
}
