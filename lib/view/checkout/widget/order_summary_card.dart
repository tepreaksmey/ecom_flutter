import 'package:ecom_flutter/controllers/cart_controller.dart';
import 'package:ecom_flutter/utils/app_textstyles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final CartController cartController = Get.find<CartController>();
    final double finalTotal = cartController.total + 1.50 + 0.50;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            context,
            'Subtotal',
            '\$${cartController.total.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(context, 'Shipping', '\$1.50'),
          const SizedBox(height: 8),
          _buildSummaryRow(context, 'Tax', '\$0.50'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
          _buildSummaryRow(
            context,
            'Total',
            '\$${finalTotal.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String lable,
    String value, {
    bool isTotal = false,
  }) {
    final textstyle = isTotal ? AppTextstyle.h3 : AppTextstyle.bodyLarge;
    final color = isTotal
        ? Theme.of(context).primaryColor
        : Theme.of(context).textTheme.bodyLarge!.color!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(lable, style: AppTextstyle.withColor(textstyle, color)),
        Text(value, style: AppTextstyle.withColor(textstyle, color)),
      ],
    );
  }
}
