import 'package:flutter/material.dart';
import 'package:prestashop_app/pages/profile.dart';
import 'card.dart';
import 'homePage.dart';
import 'salamon_bottom_bar.dart';

class ProductDetailPage extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final String prodcutPrice;
  final String productDescription;

  ProductDetailPage({
    required this.imageUrl,
    required this.productName,
    required this.prodcutPrice,
    required this.productDescription,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _currentIndex = 0;
  final screens = [
    HomePage(),
    CartPage(),
    MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                widget.imageUrl,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            Center(
              child: Row(
                children: [
                  SizedBox(width: 40),
                  Expanded(child:
                  Text(
                    widget.productName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
            Text(
              widget.prodcutPrice,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 15),
            Text(
              widget.productDescription,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("HOME"),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.shopping_bag),
            title: Text("CART"),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("PROFILE"),
            selectedColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
