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

class _HomeState extends State<HomePage> {
  late TextEditingController controller;

  //TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  void performSearch(String searchTerm) {
    setState(() {});
  }

  void navigateToProductDetail(String imagePath, String itemName, itemPrice, String itemDescription) {
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


  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                performSearch(searchTerm);
              },
              autoFocus: true,
              closeSearchOnSuffixTap: true,
              rtl: true,
            ),
            //const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Fresh items everyday',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),

            Expanded(
                child: Consumer<CartModel>(builder: (context, value, child) {
              return GridView.builder(
                itemCount: value.shopItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return GroceryItemTile(
                    itemName: value.shopItems[index][0],
                    itemPrice: value.shopItems[index][1],
                    imagePath: value.shopItems[index][2],
                    color: value.shopItems[index][3],
                    onNavigateToDetail: () {
                      navigateToProductDetail(
                        value.shopItems[index][2], // ImagePath
                        value.shopItems[index][0], // NomProduit
                        value.shopItems[index][1], // NomProduit
                        "Description du produit", // Description du produit (remplacez-la par la description réelle si vous en avez une)
                      );
                    },
                    onAddToCart: () {
                      Provider.of<CartModel>(
                        context,
                        listen: false,
                      ).addItemToCart(index);
                    },
                  );

                },
              );
            }))
            //fresh items + grid
          ],
        ),
      ),
    );
  }
}
