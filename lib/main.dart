import 'package:ecom_flutter/controllers/cart_controller.dart';
import 'package:ecom_flutter/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:http/http.dart';
import 'package:ecom_flutter/controllers/auth_controller.dart';
import 'package:ecom_flutter/controllers/theme_controller.dart';
import 'package:ecom_flutter/utils/app_themes.dart';
import 'package:ecom_flutter/view/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Important!
  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(AuthController());
  Get.put(NavigationController());
  Get.put(CartController());
  runApp(DevicePreview(builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return GetMaterialApp(
      title: "Ngeay Tinh Store",
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: themeController.theme,
      defaultTransition: Transition.fade,
      home: SplashScreen(),
    );
  }
}
