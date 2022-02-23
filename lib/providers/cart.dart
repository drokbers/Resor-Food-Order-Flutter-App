import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:resorapp/providers/product.dart';

class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String tableNo;
  final DateTime date;
  final Product food;
  final String note;
  final String voucher;

  CartItem(
      {@required this.food,
      this.date,
      @required this.id,
      this.tableNo,
      @required this.name,
      @required this.quantity,
      @required this.price,
      this.note,
      this.voucher});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, carItem) {
      total += carItem.price * carItem.quantity;
    });
    return total;
  }

  double calculateWithCoupon(int rate) {
    double amount = totalAmount;
    log(rate.toString() + "sa" + amount.toString());
    amount = (100 - rate) * amount / 100;
    return amount;
  }

  void addItem(String productId, double price, String name) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              name: existingCartItem.name,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(productId,
          () => CartItem(id: productId, name: name, quantity: 1, price: price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                name: existingCartItem.name,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void voucherCoupon() async {}
}
