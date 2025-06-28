import 'package:ecom_flutter/controllers/cart_controller.dart';
import 'package:ecom_flutter/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutBottomBar extends StatelessWidget {
  final double totalAmount;
  final VoidCallback onPlaceOrder;

  const CheckoutBottomBar({
    super.key,
    required this.totalAmount,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final CartController cartController = Get.find();

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border(
            top: BorderSide(
              color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              onPlaceOrder();
              cartController.clearCart();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: Text(
              'Place Order  •  \$${(totalAmount + 2.00).toStringAsFixed(2)}',
              style: AppTextstyle.withColor(
                AppTextstyle.buttonMedium,
                Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
