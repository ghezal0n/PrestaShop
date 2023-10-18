import 'dart:async';
import 'dart:convert';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prestashop_app/pages/productDetail.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/grocery_item_tile.dart';
import '../model/cardModel.dart';
import 'card.dart';
import 'package:http/http.dart' as http;


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
  String id;

  Data(this.label, this.color, this.id);
}

class _HomeState extends State<HomePage> {
  late TextEditingController controller;
  late CartModel cartModel;
  late String cookie;
  String _choiceIndex = '';


  final List<Data> _choiceChipsList = [
    Data("All", Colors.blueAccent,'1'),//1
    Data("Men", Colors.blueAccent,'4'),//4
    Data("Women", Colors.blueAccent,'5'),//5
    Data("Home", Colors.blueAccent,'2'), //2
    Data("Home Accessories", Colors.blueAccent,'8'),//8
    Data("Art", Colors.blueAccent,'9'),//9
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
      if ((element['name'] as String).toLowerCase().contains(search.toLowerCase())) {
        searchResult.add(element);
      }
    });
    return searchResult;
  }

  @override
  Widget build(BuildContext context) {
    cartModel = Provider.of<CartModel>(context);

    if (_firstRender) {
      cartModel.fetchProducts().then((value) => {
        setState(() {
        _searchResult = cartModel.shopItems;
        _firstRender = false;
        })
      });
    }else{
      
         cartModel.fetchProductsByCategory(_choiceIndex).then((value) =>
         {
           setState(() {
             _searchResult = cartModel.shopItems;
             _firstRender = false;
           })
         });
      } 
    
    return Scaffold(
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
            Row(
              children: [
               /* Text(
                  "hiii",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: AnimSearchBar(
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
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
                  print('_searchResult[index]');
                  print(_searchResult[index]['color']);
                  var g = GroceryItemTile(
                    itemName: _searchResult[index]['name'],
                    itemPrice: _searchResult[index]['price'],
                    imagePath: _searchResult[index]['image'],
                    color: _searchResult[index]['color'],
                    onNavigateToDetail: () {
                      navigateToProductDetail(
                        _searchResult[index]['image'], // ImagePath
                        _searchResult[index]['name'], // NomProduit
                        _searchResult[index]['price'], // NomProduit
                        _searchResult[index]['description'], // NomProduit
                        //"Description du produit", // Description du produit (remplacez-la par la description réelle si vous en avez une)
                      );
                    },
                    onAddToCart: () {
                      cartModel.addItemToCart(index);
                    },
                  );
                  print(g.itemName);
                  return g;
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
          selected: _choiceIndex == _choiceChipsList[i].id,
          selectedColor: Colors.black,
          onSelected: (bool value) {
            setState(() {
              _choiceIndex = _choiceChipsList[i].id;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
