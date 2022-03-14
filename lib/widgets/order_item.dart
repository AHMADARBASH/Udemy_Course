import 'dart:math';
import 'package:flutter/material.dart';
import '../Providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.order.amount.toStringAsFixed(2)}',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            subtitle: Text(
              widget.order.dateTime.year.toString() +
                  '\\' +
                  widget.order.dateTime.month.toString() +
                  '\\' +
                  widget.order.dateTime.day.toString() +
                  '  ' +
                  widget.order.dateTime.hour.toString() +
                  ':' +
                  widget.order.dateTime.minute.toString(),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 100, 100),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: widget.order.products
                      .map((e) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                '${e.qty}x \$${e.price}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            )
        ],
      ),
    );
  }
}
