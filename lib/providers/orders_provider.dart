import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> fetchAndSetOrders() async {
    try {
      final response = await http
          .get('https://flutter-shop-a8b96.firebaseio.com/orders.json');
      final loadedItems = json.decode(response.body) as Map<String, dynamic>;
      List<OrderItem> loadedOrders = [];
      loadedItems.forEach((id, data) {
        loadedOrders.add(OrderItem(
          id: id,
          amount: data['amount'],
          dateTime: DateTime.parse(data['dateTime']),
          orderItems: (data['products'] as List<dynamic>)
              .map(
                (prd) => CartItem(
                  id: prd['id'],
                  title: prd['title'],
                  price: prd['price'],
                  quantity: prd['quantity'],
                ),
              )
              .toList(),
        ));
      });
      _items = loadedOrders;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addItem(List<CartItem> cartItems, double amount) async {
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(
          'https://flutter-shop-a8b96.firebaseio.com/orders.json',
          body: json.encode({
            'amount': amount,
            'dateTime': timeStamp.toIso8601String(),
            'products': cartItems
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
          }));

      _items.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            orderItems: cartItems,
            amount: amount,
            dateTime: timeStamp,
          ));
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
