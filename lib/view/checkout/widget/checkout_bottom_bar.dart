import 'package:ecom_flutter/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

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

    return SafeArea(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor, // Neutral bg
        padding: const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          16,
        ), // Smaller, cleaner padding
        child: SizedBox(
          width: double.infinity,
          height: 56, // Set fixed height for clean button
          child: ElevatedButton(
            onPressed: onPlaceOrder,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            child: Text(
              'Place Order (\$${totalAmount.toStringAsFixed(2)})',
              style: AppTextstyle.withColor(
                AppTextstyle.bodyMediem,
                Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
