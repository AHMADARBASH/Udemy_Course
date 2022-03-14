import 'package:flutter/material.dart';
import 'package:shop_app/Providers/product.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  static const routeName = '/productItem';
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem({required this.id, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.RouteName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, prodcut, child) => IconButton(
                onPressed: () {
                  product.togglefavorite();
                },
                color: Colors.red,
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addItem(
                    productID: product.id,
                    price: product.price,
                    title: product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Item Added to cart'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      }),
                ));
              },
              color: Colors.red,
              icon: const Icon(Icons.shopping_cart),
            ),
            title: FittedBox(
              child: Text(
                product.title,
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }
}
