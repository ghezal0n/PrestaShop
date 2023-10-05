import 'package:flutter/material.dart';

class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final dynamic color;
  final VoidCallback? onNavigateToDetail; // Callback pour la navigation
  final VoidCallback? onAddToCart; // Callback pour ajouter au panier

  GroceryItemTile({
    Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.color,
    this.onNavigateToDetail,
    this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color[100],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: onNavigateToDetail, // Utilisez la fonction de navigation lorsque vous appuyez sur l'image
              child: Image.network(
                imagePath,
                height: 75,
              ),
            ),
            Text(itemName),
            MaterialButton(
              onPressed: onAddToCart, // Utilisez la fonction pour ajouter au panier lorsque vous appuyez sur le prix
              color: color[800],
              child: Text(
                itemPrice,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
