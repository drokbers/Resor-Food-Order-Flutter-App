import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';
import 'dart:developer' as dev;

class Products with ChangeNotifier {
  // List<Product> _items = [
  //   Product(
  //       id: 'p5',
  //       decs: 'No1. in Sales',
  //       name: 'Chicken Cheese Burger',
  //       imgUrl: 'https://i.hizliresim.com/fmg455u.png',
  //       waitTime: '15min',
  //       cal: '425',
  //       price: 8,
  //       score: 4.3,
  //       about:
  //           'A cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
  //   Product(
  //       id: 'p5',
  //       decs: 'No1. in Sales',
  //       name: 'Chicken Cheese Burger',
  //       imgUrl: 'https://i.hizliresim.com/fmg455u.png',
  //       waitTime: '15min',
  //       cal: '425',
  //       price: 8,
  //       score: 4.3,
  //       about:
  //           'A cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
  //   Product(
  //       id: 'p5',
  //       decs: 'No1. in Sales',
  //       name: 'Chicken Cheese Burger',
  //       imgUrl: 'https://i.hizliresim.com/fmg455u.png',
  //       waitTime: '15min',
  //       cal: '425',
  //       price: 8,
  //       score: 4.3,
  //       about:
  //           'A cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
  // ];

  List<Product> _items = [];
  List<Product> get items {
    fetchAndSetProducts();

    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((ProductItem) => ProductItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    var url = 'https://resor.herokuapp.com/api/categories/';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return;
      }
      //   List<dynamic> foodsList = extractedData[0]['foods'];

      String categoryId = extractedData[0]['_id'];

      //  var categoryUrl = url + categoryId + "/foods" + ;

      var foodsUrl = url + categoryId;

      final foodsResponse = await http.get(Uri.parse(foodsUrl));
      final extractedFoods = json.decode(foodsResponse.body);

      if (extractedFoods == null) {
        return;
      }
      final List<Product> loadedProducts = [];

      for (var item in extractedFoods['foods']) {
        var data = _items.where((data) => (data.id == item.id));
        if (data.isEmpty) {
          loadedProducts.add(Product(
            id: item['_id'],
            name: item['title'],
            price: item['price'].toDouble(),
            imgUrl: item['imageUrl'],
            waitTime: item['waitTime'].toString(),
            cal: item['calories'].toString(),
            score: item['description'],
            about: item['about'],
          ));
        }
      }

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
