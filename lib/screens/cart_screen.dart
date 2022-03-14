import 'package:flutter/material.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart' as ci;
import '../Providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routename = '/CartScreen';
  @override
  Widget build(BuildContext context) {
    final cartitems = Provider.of<Cart>(context);
    final orders = Provider.of<Order>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Cart'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: cartitems.items.length,
                  itemBuilder: (ctx, index) => ci.CartItem(
                        id: cartitems.items.values.toList()[index].id,
                        productId: cartitems.items.keys.toList()[index],
                        title: cartitems.items.values.toList()[index].title,
                        price: cartitems.items.values.toList()[index].price,
                        qty: cartitems.items.values.toList()[index].qty,
                      )),
            ),
            Card(
              elevation: 10,
              color: Theme.of(context).colorScheme.primary,
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount:',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Chip(
                      avatar: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        ),
                      ),
                      label: Text(
                        '${cartitems.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    TextButton(
                        onPressed: () {
                          orders.addOrder(cartitems.items.values.toList(),
                              cartitems.totalAmount);
                          cartitems.clear();
                        },
                        child: Text(
                          'Order Now',
                          style: Theme.of(context).textTheme.subtitle2,
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
