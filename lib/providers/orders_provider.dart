import 'package:flutter/foundation.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final List<CartItem> orderItems;
  final double amount;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.orderItems,
    @required this.amount,
    @required this.dateTime,
  });
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  void addItem(List<CartItem> cartItems, double amount) {
    _items.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          orderItems: cartItems,
          amount: amount,
          dateTime: DateTime.now(),
        ));
    notifyListeners();
  }
}
