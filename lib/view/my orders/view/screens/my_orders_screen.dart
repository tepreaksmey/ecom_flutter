import 'package:ecom_flutter/utils/app_textstyles.dart';
import 'package:ecom_flutter/view/my%20orders/models/order.dart';
import 'package:ecom_flutter/view/my%20orders/repository/order_repository.dart';
import 'package:ecom_flutter/view/my%20orders/view/widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrdersScreen extends StatelessWidget {
  final OrderRepository _repository = OrderRepository();
  MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            'My Orders',
            style: AppTextstyle.withColor(
              AppTextstyle.h3,
              isDark ? Colors.white : Colors.black,
            ),
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
            indicatorColor: Theme.of(context).primaryColor,
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(context, OrderStatus.active),
            _buildOrderList(context, OrderStatus.completed),
            _buildOrderList(context, OrderStatus.cancelled),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, OrderStatus status) {
    final orders = _repository.getOrdersByStatus(status);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) =>
          OrderCard(order: orders[index], onViewDetail: () {}),
    );
  }
}
