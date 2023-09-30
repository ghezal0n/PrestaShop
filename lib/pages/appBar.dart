import 'package:flutter/material.dart';
import 'package:prestashop_app/pages/profile.dart';
import 'card.dart';
import 'homePage.dart';
import 'salamon_bottom_bar.dart';

void main() {
  runApp(MyAppBar());
}

class MyAppBar extends StatefulWidget {
  static final title = 'salomon_bottom_bar';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppBar> {
  int _currentIndex = 0;
  final screens = [
    HomePage(),
    CartPage(),
    MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyAppBar.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: screens[_currentIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("HOME"),
              selectedColor: Colors.lightBlue,
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
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
