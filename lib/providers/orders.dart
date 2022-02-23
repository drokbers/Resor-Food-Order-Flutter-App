import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:resorapp/providers/product.dart';
import 'cart.dart';
import 'auth.dart';
import 'dart:developer' as dev;

String baseUrl = "https://resor.herokuapp.com";

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final int tableNo;
  final String note;
  final int voucher;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime,
      @required this.tableNo,
      this.note,
      this.voucher});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;
  int _discount;
  Orders(this.authToken, this.userId, this._orders);

  int get discount {
    return _discount;
  }

  List<OrderItem> get orders {
    fetchAndSetOrders();
    return [..._orders];
  }
Future<void> fetchAndSetOrders() async {
    var header = {
      "Content-Type": "application/json",
      "x-access-token": authToken,
    };
    final url = baseUrl + '/api/users/$userId/orders';
    dev.log(url);
    final response = await http.get(Uri.parse(url), headers: header);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body);
    if (extractedData == null) {
      return;
    }

    for (var item in extractedData) {
      loadedOrders.add(OrderItem(
        id: item['_id'],
        tableNo: item['tableNo'],
        note: item['note'],
        amount: item['totalPrice'].toDouble(),
        dateTime: DateTime.parse(item['createdAt']),
        products: (item['items'] as List<dynamic>)
            .map(
              (item) => CartItem(
                quantity: item['quantity'],
                food: Product(
                    id: item['food']["_id"],
                    decs: "",
                    name: item['food']["title"],
                    imgUrl: item['food']["imageUrl"],
                    waitTime: item['food']["waitTime"].toString(),
                    score: item['food']["description"].toString(),
                    cal: item['food']["calories"].toString(),
                    price: item['food']["price"].toDouble(),
                    about: item['food']["about"]),
              ),
            )
            .toList(),
      ));
    }

    _orders = loadedOrders.reversed.toList();
    //dev.log(_orders.length.toString());
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total,
      int tableNumber, String note,String voucher) async {
    var header = {
      "Content-Type": "application/json",
      "x-access-token": authToken,
    };
    final url = baseUrl + '/api/users/$userId/orders';

    String jsonList = cartProducts
        .map((cp) => {
              '"foodId"': '"${cp.id}"',
              '"quantity"': '"${cp.quantity}"',
            })
        .toString();

    jsonList = replaceCharAt(jsonList, 0, '[');
    jsonList = replaceCharAt(jsonList, jsonList.length - 1, ']');
    jsonList =
        '{"note": "$note","voucher": "$voucher", "tableNo": "${tableNumber}",  "items": $jsonList}';
    dev.log(jsonList);

    final timestamp = DateTime.now();
    final response =
        await http.post(Uri.parse(url), headers: header, body: jsonList);

    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
  
  Future<void> voucherCoupon(String voucher) async {
    int discountRate = 0;
    var header = {
      "Content-Type": "application/json",
      "x-access-token": authToken,
    };
    final url = baseUrl + '/api/vouchers/$voucher';
    dev.log(url);
    final response = await http.get(Uri.parse(url), headers: header);
    dev.log(response.toString());
    final extractedCoupon = json.decode(response.body);
    dev.log(extractedCoupon['discount'].toString());
    if (extractedCoupon == null) {
      return discountRate;
    }

    _discount = extractedCoupon['discount'];
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }
}
