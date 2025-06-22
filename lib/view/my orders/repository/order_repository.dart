import 'package:ecom_flutter/view/my%20orders/models/order.dart';

class OrderRepository {
  List<Order> getOrders() {
    return [
      Order(
        OrderNumber: '001',
        itemCount: 2,
        totalAmount: 198.0,
        status: OrderStatus.active,
        imageUrl: 'assets/images/laptop.jpg',
        orderDate: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Order(
        OrderNumber: '002',
        itemCount: 2,
        totalAmount: 200.0,
        status: OrderStatus.active,
        imageUrl: 'assets/images/shoe2.jpg',
        orderDate: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Order(
        OrderNumber: '003',
        itemCount: 2,
        totalAmount: 100.0,
        status: OrderStatus.completed,
        imageUrl: 'assets/images/shoe.jpg',
        orderDate: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Order(
        OrderNumber: '004',
        itemCount: 2,
        totalAmount: 150.0,
        status: OrderStatus.cancelled,
        imageUrl: 'assets/images/laptop.jpg',
        orderDate: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ];
  }

  List<Order> getOrdersByStatus(OrderStatus status) {
    return getOrders().where((order) => order.status == status).toList();
  }
}
