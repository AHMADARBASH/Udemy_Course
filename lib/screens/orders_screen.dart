import 'package:flutter/material.dart';
import '../Providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart' as OI;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routename = '/OrdersScreen';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Order>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, index) => OI.OrderItem(ordersData.orders[index]),
      ),
    ));
  }
}
