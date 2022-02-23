import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:resorapp/constant/constant.dart';
import 'package:resorapp/screens/orders_screen.dart';
import 'package:resorapp/screens/product_overview_screen.dart';

import 'package:resorapp/widgets/customAppBar.dart';
import 'package:numberpicker/numberpicker.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';
import '../widgets/selectTable.dart';
import '../widgets/selectTable.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  CartScreen({
    Key key,
    this.tablenumber,
  }) : super(
          key: key,
        );
  final int tablenumber;

  final _titleController = TextEditingController();
  final _couponController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(context);
    double finalPrice;
    String voucher;
    return Scaffold(
      backgroundColor: kBackGround,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Your Cart'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        reverse: true,
                        child: Container(
                          color: kPrimaryColor,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Form(
                                  child: TextFormField(
                                controller: _couponController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: "Enter your Coupon here",
                                    filled: true,
                                    fillColor: Colors.blue.shade100,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    )),
                              )),
                              ElevatedButton(
                                child: const Text('Apply Coupon'),
                                onPressed: () {
                                  voucher = _couponController.text;
                                  Provider.of<Orders>(context, listen: false)
                                      .voucherCoupon(voucher)
                                      .then((value) {
                                    dev.log(orders.discount.toString());
                                    int rate = orders.discount;
                                    double finalResult =
                                        cart.calculateWithCoupon(rate);
                                    finalPrice = finalResult;
                                    dev.log(finalResult.toString());
                                  });

                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(
                (MdiIcons.fromString('sale')),
                size: 35,
              )),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i], //productId
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].name),
          )),
          Card(
            child: Form(
              child: TextFormField(
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration:
                    InputDecoration.collapsed(hintText: "Enter your note here"),
                controller: _titleController,
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                      label: Text(
                        '\₺${finalPrice ?? cart.totalAmount}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: kPrimaryColor),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectTable()),
                      );
                    },
                    child: Text(tablenumber == null
                        ? 'Table: ?'
                        : 'Table: ${tablenumber}'),
                  ),
                  ElevatedButton(
                    child: Text('ORDER'),
                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                    onPressed: () {
                      String note = _titleController.text;

                      Provider.of<Orders>(context, listen: false)
                          .addOrder(cart.items.values.toList(),
                              cart.totalAmount, tablenumber, note, voucher)
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrdersScreen())));
                      cart.clear();
                      dev.log(note);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
