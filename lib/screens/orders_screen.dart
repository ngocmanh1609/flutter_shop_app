import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart' as ord_wid;
import '../widgets/app_drawer.dart';
import '../providers/orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (_, i) => ord_wid.OrderItem(ordersData.items[i]),
        itemCount: ordersData.items.length,
      ),
    );
  }
}
