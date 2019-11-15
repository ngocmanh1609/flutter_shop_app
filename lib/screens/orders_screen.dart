import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart' as ord_wid;
import '../widgets/app_drawer.dart';
import '../providers/orders_provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(Duration.zero).then((_) {
      Provider.of<OrdersProvider>(context, listen: false).fetchAndSetOrders();
      _isLoading = false;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
        itemBuilder: (_, i) => ord_wid.OrderItem(ordersData.items[i]),
        itemCount: ordersData.items.length,
      ),
    );
  }
}
