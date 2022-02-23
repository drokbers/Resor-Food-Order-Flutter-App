import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resorapp/providers/cart.dart';

import 'package:resorapp/widgets/customAppBar.dart';
import 'package:resorapp/widgets/detail_add_cart.dart';
import 'package:resorapp/widgets/detail_food_img.dart';
import 'package:resorapp/widgets/detail_food_information.dart';

import '../providers/products_provider.dart';
import '../constant/constant.dart';
import '../providers/product.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(Icons.arrow_back, Icons.favorite,
                leftCallback: () => Navigator.of(context).pop(),
                rightCallback: () {}),
            FoodImg(loadedProduct: loadedProduct),
            FoodInformation(loadedProduct: loadedProduct),
          ],
        ),
      ),
      floatingActionButton: Container(
          width: 100,
          height: 56,
          child: RawMaterialButton(
            fillColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.shopping_bag_outlined,
                    color: Colors.black, size: 30),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Text(
                    '${Provider.of<Cart>(context).itemCount}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          )),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
