import 'package:get/get.dart';
import '../models/product.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var quantities = <int>[].obs;

  double get total => cartItems.asMap().entries.fold(
    0,
    (sum, entry) => sum + entry.value.price * quantities[entry.key],
  );

  void addToCart(Product product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      quantities[index]++;
    } else {
      cartItems.add(product);
      quantities.add(1);
    }
  }

  void removeFromCart(int productId) {
    final index = cartItems.indexWhere((item) => item.id == productId);
    if (index != -1) {
      cartItems.removeAt(index);
      quantities.removeAt(index);
    }
  }

  void increaseQty(int index) {
    if (index >= 0 && index < quantities.length) {
      quantities[index]++;
    }
  }

  void decreaseQty(int index) {
    if (index >= 0 && index < quantities.length && quantities[index] > 1) {
      quantities[index]--;
    }
  }

  void clearCart() {
    cartItems.clear();
    quantities.clear();
  }
}
