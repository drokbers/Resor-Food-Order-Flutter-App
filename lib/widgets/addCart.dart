import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:resorapp/providers/cart.dart';
import 'package:resorapp/providers/product.dart';

class AddtoCart extends StatelessWidget {
  const AddtoCart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Container(
      child: IconButton(
        onPressed: () {
          cart.addItem(product.id, product.price, product.name);
        },
        icon: Icon(Icons.shopping_cart),
      ),
    );
  }
}
