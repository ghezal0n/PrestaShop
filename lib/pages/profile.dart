import 'package:flutter/material.dart';

import 'LoginPage.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
                    border: Border.all(width: 2, color: Color.fromARGB(255, 245, 7, 7)),
                  ),
                  child: const CircleAvatar(
                    foregroundImage: AssetImage("assets/image/Logo.png"),
                  ),
                ),

                Row(
                  children: [
                    Text("First name", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87),),
                    Spacer()
                  ],
                ),

                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: Color(0xFFA4DAE7),
                  leading: Icon(Icons.mail),
                  title: Text("First name"),
                ),
                SizedBox(height: 15,),

                Row(
                  children: [
                    Text("Last name", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87),),
                    Spacer()
                  ],
                ),

                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: Color(0xFFA4DAE7),
                  leading: Icon(Icons.mail),
                  title: Text("Last name"),
                ),
                SizedBox(height: 15,),

                Row(
                  children: [
                    Text("Email", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87),),
                    Spacer()
                  ],
                ),

                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: Color(0xFFA4DAE7),
                  leading: Icon(Icons.mail),
                  title: Text("aoffahad@gmail.com"),
                ),
                SizedBox(height: 15,),

                Row(
                  children: [
                    Text("ID user", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87),),
                    Spacer()
                  ],
                ),

                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: Color(0xFFA4DAE7),
                  leading: Icon(Icons.more_outlined),
                  title: Text("id"),
                ),
                SizedBox(height: 15,),

                Row(
                  children: [
                    Text("Creation date", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87),),
                    Spacer()
                  ],
                ),

                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: Color(0xFFA4DAE7),
                  leading: Icon(Icons.date_range_outlined),
                  title: Text("date_add"),
                ),
                SizedBox(height: 15,),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.exit_to_app_rounded ), // Icône de votre bouton
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  LoginPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
