import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../pages/LoginPage.dart';

class CartModel extends ChangeNotifier {
  late LoginPage loginPage;
  late String cookie;
  final colors = [
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.orange,
  ];

  List _shopItems = [
    // itemName, itemPrice, imagePath, color
  /*  {
      'name': 'Avocado',
      'price':'4.00',
      'image':'assets/image/Logo.png',
      'color':Colors.green,
    },
    {
      'name': 'Banana',
      'price':'4.00',
      'image':'assets/image/Logo.png',
      'color':Colors.yellow,
    },
    {
      'name': 'Chicken',
      'price':'4.00',
      'image':'assets/image/Logo.png',
      'color':Colors.brown,
    },
    {
      'name': 'Avocado banane',
      'price':'4.00',
      'image':'assets/image/Logo.png',
      'color':Colors.yellow,
    },
    {
      'name': 'Banana',
      'price':'4.00',
      'image':'assets/image/Logo.png',
      'color':Colors.yellow,
    },
    {
      'name': 'Water',
      'price':'1.00',
      'image':'assets/image/Logo.png',
      'color':Colors.blue,
    },*/

    // ['Avocado', '4.00', "assets/image/Logo.png", Colors.green],
    // ['Banana', '2.50', "assets/image/Logo.png", Colors.yellow],
    // ['Chicken', '12.80', "assets/image/Logo.png", Colors.brown],
    // ['Avocado', '4.00', "assets/image/Logo.png", Colors.green],
    // ['Banana', '2.50', "assets/image/Logo.png", Colors.yellow],
    // ['Chicken', '12.80', "assets/image/Logo.png", Colors.brown],
    // ['Water', '1.00', "assets/image/Logo.png", Colors.blue]
  ];

  final List _cartItems = [];

  get shopItems => _shopItems;
  get cartItems => _cartItems;


  List parseProducts(String responseBody){
    final products = json.decode(responseBody)['psdata']['products'] as List;
    List finalProducts = [];
    for (int i = 0; i<products.length; i++) {
      var item = products[i];
      finalProducts.add({
        'id': item['id_product'],
        'name': item['name'],
        'image': item['default_image']['url'],
        'description': item['description'],
        'price': item['price'],
        'color': colors[i % colors.length],
      });
    }
    print(finalProducts);
    return finalProducts;
  }

  Future<void> fetchProducts() async {
    final Uri url = Uri.https('rest.binshops.com', 'rest/wishlist', {
      'action': 'viewWishlist',
      'category_name': 'home',
    });
    final response = await http.get(url, headers: {
      "Cookie": cookie,
    });

    if (response.statusCode == 200) {
      final List products = parseProducts(response.body);
      _shopItems = products;
      notifyListeners();
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }


  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  String calculTotal() {
    double total = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      double doublePrice = double.parse((_cartItems[i]['price'] as String).split('\$')[1]);
      total += doublePrice;
    }

    return total.toStringAsFixed(2);
  }
}