import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
      {required this.id, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProdcutScreen.routename, arguments: id);
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                  scaffold.showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Center(child: Text('Prodct Deleted')),
                        ],
                      )));
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Center(child: Text('Deleting Error!')),
                        ],
                      )));
                }
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
