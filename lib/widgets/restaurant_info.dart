import 'package:flutter/material.dart';
import 'package:resorapp/constant/constant.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BurgerLand',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '20-30 min',
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Burger',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.withOpacity(0.4)),
                      ),
                    ],
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  'https://media.istockphoto.com/photos/hamburger-with-cheese-and-french-fries-picture-id1188412964?s=170667a',
                  width: 80,
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bite into tender juicy goodness.',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_outline,
                    color: kPrimaryColor,
                  ),
                  Text(
                    '4.7',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
