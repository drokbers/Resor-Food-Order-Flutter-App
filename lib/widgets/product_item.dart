import 'package:flutter/material.dart';
import 'package:resorapp/constant/constant.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String decs;
  // final String name;
  // final String imgUrl;
  // ProductItem(this.id, this.decs, this.name, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context,listen: false);

    return Container(
      height: 110,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            width: 110,
            height: 110,
            child: Image.network(
              product.imgUrl,
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      '\₺',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${product.price}',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     cart.addItem(product.id, product.price, product.name);
                    //   },
                    //   icon: Icon(Icons.add_shopping_cart_outlined),
                    // )
                  ],
                )
              ],
            ),
          )),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        ProductDetailScreen.routeName,
                        arguments: product.id);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  )),
              Consumer<Product>(
                builder: (context, value, child) => IconButton(
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () {
                    product.toggleFavoriteStatus();
                  },
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
