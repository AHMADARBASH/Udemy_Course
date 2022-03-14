import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int qty;
  final String title;

  CartItem({
    required this.id,
    required this.productId,
    required this.price,
    required this.qty,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        padding: const EdgeInsets.all(10),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text(
                      'Do you want to delete this item from the cart?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('No')),
                  ],
                ));
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        carts.removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 30,
              child: FittedBox(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '\$$price',
                  style: const TextStyle(color: Colors.white),
                ),
              )),
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
            subtitle: Text('Total: \$ ${(price * qty).toStringAsFixed(2)}'),
            trailing: Text('$qty x'),
          ),
        ),
      ),
    );
  }
}
