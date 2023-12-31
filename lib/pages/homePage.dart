import 'dart:async';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prestashop_app/pages/productDetail.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import '../model/cardModel.dart';
import 'card.dart';

void main() => runApp(
    const MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class Data {
  String label;
  Color color;

  Data(this.label, this.color);
}

class _HomeState extends State<HomePage> {
  late TextEditingController controller;
  int _choiceIndex = 0;
  final List<Data> _choiceChipsList = [
    Data("All", Colors.blueAccent),
    Data("Men", Colors.blueAccent),
    Data("Women", Colors.blueAccent),
    Data("Choice 3", Colors.blueAccent),
    Data("Choice 4", Colors.blueAccent),
    Data("Choice 4", Colors.blueAccent),
  ];
  List _searchResult = [];
  bool _firstRender = true;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();


    //TextEditingController controller = TextEditingController();
  }

  void performSearch(List items, String searchTerm) {
    setState(() {
      _searchResult = searchItems(items, searchTerm);
    });
  }

  void navigateToProductDetail(
      String imagePath, String itemName, itemPrice, String itemDescription) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          imageUrl: imagePath,
          productName: itemName,
          prodcutPrice: itemPrice,
          productDescription: itemDescription,
        ),
      ),
    );
  }

  List searchItems(List items, String search) {
    List searchResult = [];
    items.forEach((element) {
      if (element['name'].contains(search)) {
        searchResult.add(element);
      }
    });
    return searchResult;
  }

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);

    if (_firstRender) {
      setState(() {
        _searchResult = cartModel.shopItems;
        _firstRender = false;
      });
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const CartPage();
            },
          ),
        ),
        backgroundColor: Colors.black,
        child: const Icon(Icons.shopping_bag),
      ),
      body: SafeArea(
        //const SizedBox(height: 40),
        /* const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Let\'s order fresh items for you',
                style: GoogleFonts.notoSerif(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),*/

        /*AnimationSearchBar(
                backIconColor: Colors.black,
                centerTitle: 'App Title',
                onChanged: (text) => debugPrint(text),
                searchTextEditingController: controller,
                horizontalPadding: 5),*/

        //const SizedBox(height: 24),
        /*const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(),
            ),*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimSearchBar(
              width: MediaQuery.of(context).size.width,
              textController: controller,
              onSuffixTap: () {
                setState(() {
                  controller.clear();
                });
              },
              helpText: "Search..",
              onSubmitted: (String searchTerm) {
                performSearch(cartModel.shopItems, searchTerm);
              },
              autoFocus: true,
              closeSearchOnSuffixTap: true,
              rtl: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              direction: Axis.horizontal,
              children: choiceChips(),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: _searchResult.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return GroceryItemTile(
                    itemName: _searchResult[index]['name'],
                    itemPrice: _searchResult[index]['price'],
                    imagePath: _searchResult[index]['image'],
                    color: _searchResult[index]['color'],
                    onNavigateToDetail: () {
                      navigateToProductDetail(
                        _searchResult[index]['image'], // ImagePath
                        _searchResult[index]['name'], // NomProduit
                        _searchResult[index]['price'], // NomProduit
                        "Description du produit", // Description du produit (remplacez-la par la description réelle si vous en avez une)
                      );
                    },
                    onAddToCart: () {
                      cartModel.addItemToCart(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: ChoiceChip(
          label: Text(_choiceChipsList[i].label),
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: _choiceChipsList[i].color,
          selected: _choiceIndex == i,
          selectedColor: Colors.black,
          onSelected: (bool value) {
            setState(() {
              _choiceIndex = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
