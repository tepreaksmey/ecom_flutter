import 'package:ecom_flutter/controllers/cart_controller.dart';
import 'package:ecom_flutter/utils/app_textstyles.dart';
import 'package:ecom_flutter/view/checkout/widget/address_card.dart';
import 'package:ecom_flutter/view/checkout/widget/checkout_bottom_bar.dart';
import 'package:ecom_flutter/view/checkout/widget/order_summary_card.dart';
import 'package:ecom_flutter/view/checkout/widget/payment_method_card.dart';
import 'package:ecom_flutter/view/order%20comfirmation/screen/order_information_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final CartController cartController = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Checkout',
          style: AppTextstyle.withColor(
            AppTextstyle.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Shipping Address'),
            const SizedBox(height: 16),
            AddressCard(),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Payment Method'),
            const SizedBox(height: 16),
            const PaymentMethodCard(),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Order Summary'),
            const SizedBox(height: 16),
            const OrderSummaryCard(),
          ],
        ),
      ),
      bottomNavigationBar: CheckoutBottomBar(
        totalAmount:
            cartController.total, // Replace with your dynamic total if needed
        onPlaceOrder: () {
          // Generate a unique order number
          final orderNumber =
              'ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

          // Navigate to order confirmation
          Get.to(
            () => OrderConfirmationScreen(
              orderNumber: orderNumber,
              totalAmount: cartController.total,
              // Make sure this matches your actual cart total
            ),
          );

          // Optional: clear the cart after placing the order
          // cartController.clearCart(); // Uncomment if using GetX cart logic
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextstyle.withColor(
        AppTextstyle.h3,
        Theme.of(context).textTheme.bodyLarge!.color!,
      ),
    );
  }
}
