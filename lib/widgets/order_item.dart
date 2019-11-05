import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders_provider.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orderItem;

  OrderItem(this.orderItem);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;

  Widget itemWidget(String title, String price) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 40),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.title,
            ),
            Text('\$${price}'),
          ],
        ),
      ),
    );
  }

  double getHeightItemsList() {
    // all items have the same height, so let's take the first item to calculate
    double itemHeight = (itemWidget(widget.orderItem.orderItems[0].title, widget.orderItem.orderItems[0].price.toString()) as PreferredSize).preferredSize.height;
    return itemHeight * widget.orderItem.orderItems.length;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm')
                .format(widget.orderItem.dateTime)),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              width: double.infinity,
              height: getHeightItemsList(),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: widget.orderItem.orderItems
                    .map((item) => itemWidget(item.title, item.price.toString()),)
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
