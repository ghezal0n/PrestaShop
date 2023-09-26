import 'package:flutter/material.dart';
import 'package:prestashop_app/pages/LoginPage.dart';
import 'package:provider/provider.dart';

import 'model/cardModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CartModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        )
    );
  }
}