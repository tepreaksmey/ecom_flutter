import 'package:ecom_flutter/controllers/navigation_controller.dart';
import 'package:ecom_flutter/controllers/theme_controller.dart';
import 'package:ecom_flutter/view/account_screen.dart';
import 'package:ecom_flutter/view/home_screen.dart';
import 'package:ecom_flutter/view/shopping_screen.dart';
import 'package:ecom_flutter/view/widgets/custom_bottom_navbar.dart';
import 'package:ecom_flutter/view/wishlist_screenn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();
    return GetBuilder<ThemeController>(
      builder: (themeController) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Obx(
            () => IndexedStack(
              key: ValueKey(navigationController.currentIndex.value),
              index: navigationController.currentIndex.value,
              children: [
                HomeScreen(),
                ShoppingScreen(),
                WishlistScreen(),
                AccountScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavbar(),
      ),
    );
  }
}
