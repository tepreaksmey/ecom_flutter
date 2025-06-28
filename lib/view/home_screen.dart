import 'package:ecom_flutter/controllers/auth_controller.dart';
import 'package:ecom_flutter/controllers/theme_controller.dart';
import 'package:ecom_flutter/view/all_products.dart';
import 'package:ecom_flutter/view/cart_screen.dart';
import 'package:ecom_flutter/view/notifications/views/notifications_screen.dart';
import 'package:ecom_flutter/view/shopping_screen.dart';
import 'package:ecom_flutter/view/widgets/category_chips.dart';
import 'package:ecom_flutter/view/widgets/custom_search_bar.dart';
import 'package:ecom_flutter/view/widgets/product_grid.dart';
import 'package:ecom_flutter/view/widgets/sale_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final name = authController.currentUser.value?.name ?? 'Guest';
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            //header section
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello $name',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Get.to(() => NotificationsScreen()),
                    icon: const Icon(Icons.notification_add_outlined),
                  ),
                  //cart btn
                  IconButton(
                    onPressed: () => Get.to(() => CartScreen()),
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                  //theme btn
                  GetBuilder<ThemeController>(
                    builder: (controller) => IconButton(
                      onPressed: () => controller.toggleTheme(),
                      icon: Icon(
                        controller.isDarkMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // search bar
            const CustomSearchBar(),
            // category
            // const CategoryChips(),
            //sale banner
            const SaleBanner(),

            //popular product
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Product',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => ShoppingScreen()),
                    child: Text(
                      'See All',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            //product grid
            const Expanded(child: ProductGrid()),
          ],
        ),
      ),
    );
  }
}
