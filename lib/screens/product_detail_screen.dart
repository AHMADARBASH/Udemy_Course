import 'dart:ui';

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
    final appbar = AppBar(
      title: Text(loadedProduct.title),
    );

    return SafeArea(
      child: Scaffold(
        appBar: appbar,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomCenter, children: [
              SizedBox(
                width: double.infinity,
                height: (MediaQuery.of(context).size.height -
                    appbar.preferredSize.height -
                    MediaQuery.of(context).padding.top),
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: double.infinity,
                    color: Colors.white.withOpacity(0.2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${loadedProduct.price}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          loadedProduct.description,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 26,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
