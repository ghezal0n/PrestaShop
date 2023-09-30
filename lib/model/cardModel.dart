import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    // itemName, itemPrice, imagePath, color
    {
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
    },

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
      total += double.parse(_cartItems[i]['price']);
    }

    return total.toStringAsFixed(2);
  }
}