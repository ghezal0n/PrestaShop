import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prestashop_app/components/my_Button.dart';
import 'package:prestashop_app/pages/updateUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {

  MyProfile( {Key? key} );

  @override
  State<MyProfile> createState() => _MyProfileState();
}

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
    final Uri url = Uri.https('rest.binshops.com', 'rest/accountInfo', {});
    final response = await http.get(url, headers: {
      "Cookie": cookie,
    });

    if (response.statusCode == 200) {
      final List accounts = consumProfile(response.body);
      setState(() {
        _profileData = accounts;
      });

     /* print('_profileData: $_profileData');

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');*/
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
    /*print('_profileData: $_profileData');
    print('_profileData: ${_profileData[0]['id']}');

    print('Response Status Code2: ${response.statusCode}');
    print('Response Body2: ${response.body}');*/
  }

  // List consumProfile(String responseBody){
  //   final accounts = json.decode(responseBody)['psdata'] as List;
  //   List finalAccount = [];
  //   for (int i = 0; i<accounts.length; i++) {
  //     var item = accounts[i];
  //     finalAccount.add({
  //       'id': item['id'],
  //       'firstName': item['firstname'],
  //       'lastName': item['lastname'],
  //       'email': item['email'],
  //       'dateAdd': item['date_add'],
  //     });
  //   }
  //   print(finalAccount);
  //   return finalAccount;
  // }

  List consumProfile(String responseBody) {
    final jsonBody = json.decode(responseBody);
    final psdata = jsonBody['psdata'] as Map<String, dynamic>;

    List finalAccount = []; // Declare finalAccount as an empty list

    finalAccount.add({
      'id': psdata['id'],
      'firstName': psdata['firstname'],
      'lastName': psdata['lastname'],
      'email': psdata['email'],
      'dateAdd': psdata['date_add'],
    });

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
                  leading: Icon(Icons.account_circle),
                  //'First Name: ${_profileData.isNotEmpty ? _profileData[0]['firstName'] : 'Non disponible'}',
                  title: Text(
                    '${_profileData.isNotEmpty ? _profileData[0]['firstName'] : 'Non disponible'}',
                  ),
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
                  leading: Icon(Icons.account_circle),
                  title: Text(
                    '${_profileData.isNotEmpty ? _profileData[0]['lastName'].toString() : 'Non disponible'}',
                  ),
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
                  title: Text(
                    '${_profileData.isNotEmpty ? _profileData[0]['email'].toString() : 'Non disponible'}',
                  ),
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
                  title: Text(
                    '${_profileData.isNotEmpty ? _profileData[0]['id'].toString() : 'Non disponible'}',
                  ),
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
                  title: Text(
                    '${_profileData.isNotEmpty ? _profileData[0]['dateAdd'].toString() : 'Not avalible'}',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Row(
                  children: [
                   Spacer(),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        width: 150,
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            //updateUser(),
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdatePage(_profileData[0]['firstName'],_profileData[0]['lastName'],_profileData[0]['email'],_profileData[0]['firstName'])));
                          },
                          child: Ink(
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.update),
                                  SizedBox(width: 8),
                                  Text("Edit account"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),

                  ],
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
