import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../Providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // ignore: constant_identifier_names
  static const RouteName = '/productDetailScreen';
  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findbyID(productID);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(loadedProduct.title),
        ),
        body: Column(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.50,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '\$${loadedProduct.price}',
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
