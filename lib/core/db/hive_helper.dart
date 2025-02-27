import 'package:hive/hive.dart';

class HiveDBHelper {
  static final HiveDBHelper _instance = HiveDBHelper._internal();
  factory HiveDBHelper() => _instance;
  HiveDBHelper._internal();

  final String _cartBoxName = 'cartBox';

  Box get _cartBox => Hive.box(_cartBoxName);

  void addToCart(Map<String, dynamic> product) {
    _cartBox.put(product['id'], product);
  }

  void removeFromCart(String productId) {
    _cartBox.delete(productId);
  }

  List<Map<dynamic, dynamic>> getCartItems() {
    return _cartBox.values.toList().cast<Map<dynamic, dynamic>>();
  }

  void clearCart() {
    _cartBox.clear();
  }
}
