import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
   MyProfile({Key? key});


  @override
  State<MyProfile> createState() => _MyProfileState();
}
//https://rest.binshops.com/rest/accountInfo


class _MyProfileState extends State<MyProfile> {


  late String cookie;
  List _profileData = [];

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }
  Future<void> fetchProducts() async {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      cookie = prefs.getString('cookie')!;
      final Uri url = Uri.https('rest.binshops.com', 'rest/accountInfo', {

      });
      // final Uri url = Uri.https('rest.binshops.com', 'rest/wishlist', {
      //   'action': 'viewWishlist',
      //   'category_name': 'home',
      // });
      final response = await http.get(url, headers: {
        "Cookie": cookie,
      });

      if (response.statusCode == 200) {
        final List accounts = consumProfile(response.body);
        _profileData = accounts;
      } else {
        throw Exception('Unable to fetch products from the REST API');
      }

  }
  List consumProfile(String responseBody){
    final accounts = json.decode(responseBody)['psdata'] as List;
    List finalAccount = [];
    for (int i = 0; i<accounts.length; i++) {
      var item = accounts[i];
      finalAccount.add({
        'id': item['id'],
        'firstName': item['firstname'],
        'lastName': item['lastname'],
        'email': item['email'],
        'dateAdd': item['date_add'],
      });
    }
    print(finalAccount);
    return finalAccount;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 22),
                  padding: EdgeInsets.all(6),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 2, color: Color.fromARGB(255, 245, 7, 7)),
                  ),
                  child: const CircleAvatar(
                    foregroundImage: AssetImage("assets/image/Logo.png"),
                  ),
                ),

                Text(
                  //"Votre texte ici",
                   //_profileData[0]['id'],
                  'ID: ${_profileData.isNotEmpty ? _profileData[0]['id'] : ''}',

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                Row(
                  children: [
                    Text(
                      "First name",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87),
                    ),
                    Spacer()
                  ],
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Color(0xFFA4DAE7),
                  leading: Icon(Icons.mail),
                  title: Text("First name"),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Last name",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87),
                    ),
                    Spacer()
                  ],
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Color(0xFFA4DAE7),
                  leading: Icon(Icons.mail),
                  title: Text("Last name"),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87),
                    ),
                    Spacer()
                  ],
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Color(0xFFA4DAE7),
                  leading: Icon(Icons.mail),
                  title: Text("aoffahad@gmail.com"),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "ID user",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87),
                    ),
                    Spacer()
                  ],
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Color(0xFFA4DAE7),
                  leading: Icon(Icons.more_outlined),
                  title: Text("id"),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Creation date",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87),
                    ),
                    Spacer()
                  ],
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Color(0xFFA4DAE7),
                  leading: Icon(Icons.date_range_outlined),
                  title: Text("date_add"),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Row(
                children: [
                  Icon(Icons.exit_to_app_rounded),
                  SizedBox(width: 8),
                  Text("Logout"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
