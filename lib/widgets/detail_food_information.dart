import 'package:flutter/material.dart';
import 'package:resorapp/constant/constant.dart';
import 'package:resorapp/providers/product.dart';
import 'package:resorapp/widgets/detail_add_cart.dart';
import 'dart:developer' as dev;

class FoodInformation extends StatelessWidget {
  const FoodInformation({
    Key key,
    @required this.loadedProduct,
  }) : super(key: key);

  final Product loadedProduct;
  
  @override
  Widget build(BuildContext context) {
   
    return Container(
      color: kBackGround,
      child: Column(
        children: [
          Text(
            loadedProduct.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconText(Icons.access_time_filled_outlined, Colors.blue,
                  loadedProduct.waitTime.toString()),
              _buildIconText(Icons.star_outline_outlined, Colors.amber,
                  loadedProduct.score.toString()),
              _buildIconText(Icons.local_fire_department_outlined, Colors.red,
                  loadedProduct.cal.toString()),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          AddCart(loadedProduct: loadedProduct),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(loadedProduct.about,
              style: TextStyle(
                wordSpacing: 1.2,
                height: 1.5,
                fontSize: 16,
              )),
          Container(
            height: 140,
          ),
        ],
      ),
    );
  }
}

Widget _buildIconText(IconData icon, Color color, String text) {
  return Row(
    children: [
      Icon(
        icon,
        color: color,
        size: 20,
      ),
      Text(
        text,
        style: TextStyle(fontSize: 16),
      )
    ],
  );
}
