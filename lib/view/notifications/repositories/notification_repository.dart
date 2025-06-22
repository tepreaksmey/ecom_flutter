import 'package:ecom_flutter/view/notifications/models/notification_type.dart';

class NotificationRepository {
  List<NotificationItem> getNotifications() {
    return const [
      NotificationItem(
        title: 'Order Confirmed',
        message: 'Your order #123 has been comfirmed and is begin processed.',
        time: '3 minutes ago',
        type: NotificationType.promo,
        isRead: true,
      ),
      NotificationItem(
        title: 'Spacial Offer!',
        message: 'Get 20% off on all shoes this weekend!',
        time: '2 hour ago',
        type: NotificationType.promo,
      ),
      NotificationItem(
        title: 'Out for Delivery',
        message: 'Your order #123 is out for delivery.',
        time: '3 minutes ago',
        type: NotificationType.delivery,
        isRead: true,
      ),
      NotificationItem(
        title: 'Payment Sucessful',
        message: 'Payment for order #4241 was sucessful.',
        time: '1 minutes ago',
        type: NotificationType.payment,
        isRead: true,
      ),
    ];
  }
}
