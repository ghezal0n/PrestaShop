import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Produit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image du produit
            Image.network(
              imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover, // Ajustez le mode d'ajustement de l'image
            ),
            SizedBox(height: 20),

            Text(
              productName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            Text(
              '\$'+ prodcutPrice,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            Text(
              productDescription,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
