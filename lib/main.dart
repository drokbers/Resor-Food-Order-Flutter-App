import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resorapp/screens/product_overview_screen.dart';

import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import 'providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import 'screens/auth_screen.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProduct) => Products(),
            create: (_) {},
          ),
          ChangeNotifierProvider(create: (context) => Cart()),
          ChangeNotifierProxyProvider<Auth,Orders>(
            update: (ctx, auth, previousOrder) =>Orders(auth.token, auth.userId,
                previousOrder == null ? [] : previousOrder.orders,),
               create: (_) {},
          )
        ],

        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ResorApp',
            theme: ThemeData(
                primaryColor: Colors.blue, accentColor: Colors.deepOrange),
            home:  auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
            routes: {
              ProductOverviewScreen.routeName: (ctx) => ProductOverviewScreen(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
            },
          ),
        ));
  }
}

