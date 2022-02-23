import 'dart:convert';
import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _userId;
  String baseUrl = "https://resor.herokuapp.com";
  String _token;
  DateTime _expiryDate;

  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    return _token;
  }

  String get userId {
    return _userId;
  }

  Future<String> login(String email, String password) async {
    var header = {"Content-Type": "application/json"};

    final response = await http.post(Uri.parse('$baseUrl/login'),
        headers: header,
        body: json.encode({"email": email, "password": password}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      _token = jsonResponse['token'];
      _userId = jsonResponse['id'];
     
      return "Success";
    } else {
      _token = null;
      throw Exception('Failed to load data!');
    }
  }

  Future<String> signup(String email, String password) async {
    var header = {"Content-Type": "application/json"};

    final response = await http.post(Uri.parse('$baseUrl/register'),
        headers: header,
        body: json.encode({
          "firstName": " ",
          "lastName": " ",
          "email": email,
          "password": password
        }));
   
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      _token = jsonResponse['token'];
      _userId = jsonResponse['id'];
      login(email, password);
      return "Success";
    } else {
      _token = null;
      throw Exception('Failed to load data!');
    }
  }

  Future<String> fetchRestaurants() async {
    // if (_token != null) {
    //   var header = {"Content-Type": "application/json"};

    //   final response = await http.post(Uri.parse('$baseUrl/login'),
    //       headers: header,
    //       body: json.encode({"email": email, "password": password}));

    //   if (response.statusCode == 200) {
    //     final jsonResponse = json.decode(response.body);
    //     _token = jsonResponse['token'];

    //     return "Success";
    //   } else {
    //     _token = null;
    //     throw Exception('Failed to load data!');
    //   }
    // }
  }
}
