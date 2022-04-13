import 'package:flutter/material.dart';
import '../Providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart' as OI;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routename = '/OrdersScreen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Your Orders'),
            ),
            body: FutureBuilder(
              future: Provider.of<Orders>(context, listen: false)
                  .fetchandSetOrders(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.error != null) {
                  return const Center(child: Text('an error occured!'));
                } else if (snapshot.hasData) {
                  return Consumer<Orders>(
                    builder: (ctx, ordersdata, child) {
                      return ListView.builder(
                        itemCount: ordersdata.orders.length,
                        itemBuilder: (ctx, i) =>
                            OI.OrderItem(ordersdata.orders[i]),
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: Text(
                    'no Orders for you',
                    style: TextStyle(fontSize: 24),
                  ));
                }
              },
            )));
  }
}
