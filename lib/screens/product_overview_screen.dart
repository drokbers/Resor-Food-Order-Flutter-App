import 'package:flutter/material.dart';
import 'package:resorapp/constant/constant.dart';
import 'package:provider/provider.dart';
import 'package:resorapp/screens/auth_screen.dart';
import 'package:resorapp/screens/orders_screen.dart';
import 'package:resorapp/widgets/customAppBar.dart';

import '../widgets/products_grid.dart';
import '../widgets/restaurant_info.dart';

import '../providers/cart.dart';
import './cart_screen.dart';
import '../providers/auth.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/products';
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;

  var favs = 0;
  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ss'),
      //   actions: <Widget>[
      //     PopupMenuButton(
      //       onSelected: (FilterOptions selectedvalue) {
      //         setState(() {
      //           if (selectedvalue == FilterOptions.Favorites) {
      //             _showOnlyFavorites = true;
      //           } else {
      //             _showOnlyFavorites = false;
      //           }
      //         });
      //       },
      //       itemBuilder: (context) => [
      //         PopupMenuItem(
      //           child: Text('Only Fav'),
      //           value: FilterOptions.Favorites,
      //         ),
      //         PopupMenuItem(
      //           child: Text('Show all'),
      //           value: FilterOptions.All,
      //         )
      //       ],
      //       icon: Icon(Icons.more_vert),
      //     ),

      //provider ile tum sayfayiyeniden yuklemeye gerek yok
      // bu metotla sadece lazaim olani aliyoz

      // Consumer<Cart>(
      //   builder: (_, cart, child) => Badge(
      //     child: child! as Widget,
      //     value: cart.itemCount.toString(),
      //   ),
      //   child: IconButton(
      //     icon: Icon(Icons.shopping_cart),
      //     onPressed: () {
      //       Navigator.of(context).pushNamed(CartScreen.routeName);
      //     },
      //   ),
      // )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(Icons.arrow_back, Icons.logout, rightCallback: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );
            }),
            RestaurantInfo(),
            FittedBox(
                child: Container(
                    width: 400,
                    height: 670,
                    child: ProductsGrid(_showOnlyFavorites))),
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
      //sepet

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 35),
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, -7),
                  blurRadius: 33,
                  color: Color(0xFF6DAED9).withOpacity(0.11))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                 Navigator.of(context).pushReplacementNamed(ProductOverviewScreen.routeName);
              },
              icon: Icon(Icons.home),
              iconSize: 35,
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
                },
                icon: Icon(
                  Icons.payment,
                  size: 35,
                )),
            IconButton(
              onPressed: () {
                setState(() {
                  favs = 1 - favs;
                  if (favs == 1) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: favs == 0
                  ? Icon(Icons.favorite_border_outlined)
                  : Icon(Icons.favorite),
              iconSize: 35,
            ),
          ],
        ),
      ),
    );
  }
}
