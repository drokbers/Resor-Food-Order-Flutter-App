import 'package:flutter/material.dart';
import 'package:resorapp/constant/constant.dart';
import 'package:resorapp/screens/orders_screen.dart';

import '../screens/product_overview_screen.dart';

class CustomAppBar extends StatelessWidget {
  final IconData LeftIcon;
  final IconData RightIcon;
  final Function leftCallback;
  final Function rightCallback;

  CustomAppBar(this.LeftIcon, this.RightIcon,
      {this.leftCallback, this.rightCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: leftCallback != null ? () => leftCallback() : null,
            child: _buildIcon(LeftIcon),
          ),
          GestureDetector(
            onTap: rightCallback != null ? () => rightCallback() : null,
            child: _buildIcon(RightIcon),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Icon(icon),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(20),
          //   topRight: Radius.circular(20),
          // ),
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
            onPressed: () {},
            icon: Icon(Icons.favorite_outline_outlined),
            iconSize: 35,
          ),
        ],
      ),
    );
  }
}
