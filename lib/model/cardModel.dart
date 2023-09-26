import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    // itemName, itemPrice, imagePath, color
    ['Avocado', '4.00', 'assets/image/download.jpg', Colors.green],
    ['Banana', '2.50', 'assets/image/download.jpg', Colors.yellow],
    ['Chicken', '12.80', 'assets/image/download.jpg', Colors.brown],
    ['Avocado', '4.00', 'assets/image/download.jpg', Colors.green],
    ['Banana', '2.50', 'assets/image/download.jpg', Colors.yellow],
    ['Chicken', '12.80', 'assets/image/download.jpg', Colors.brown],
    ['Water', '1.00', 'assets/image/download.jpg', Colors.blue]
  ];

  final List _cartItems = [];

  get shopItems => _shopItems;
  get cartItems => _cartItems;

  // add to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // total price
  String calculTotal() {
    double total = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      total += double.parse(_cartItems[i][1]);
    }

    return total.toStringAsFixed(2);
  }
}