import 'dart:convert';
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:prestashop_app/pages/RegisterPage.dart';
import 'package:provider/provider.dart';
import '../components/my_Button.dart';
import '../components/my_textfield.dart';
import '../components/square_title.dart';
import 'package:http/http.dart' as http;

import '../model/cardModel.dart';
import 'appBar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  // sign user in method
  Future<String?> signIn(String email, String password ) async {
    final Uri url = Uri.https('rest.binshops.com','rest/login');
    print(email);
    print(password);
    final response = await http.post(url, headers: { "Access-Control-Allow-Origin": "*" } , body: jsonEncode(<String, String>{
      "email": email,
      "password": password,
    }));

    if (response.statusCode == 200) {
      String? longCookie = response.headers['set-cookie'];
      int indexOfSecondCookie = longCookie!.indexOf("PrestaShop", 20);
      String cookie = longCookie.substring(indexOfSecondCookie, longCookie.indexOf(";", indexOfSecondCookie));
      return cookie;
    } else {
      return null;
      //popup,chaineVide
    }

  }

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: "assets/image/Logo.png"),


                  SizedBox(width: 25),
                ],
              ),

              const SizedBox(height: 50),

              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              MyTextField(
                controller: emailController,
                hintText: 'Email',
                labelText: 'email',
                obscureText: false, labelStyle: '',

              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true, labelText: '', labelStyle: '',

              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                 onTap: () async {
                   final SharedPreferences prefs = await SharedPreferences.getInstance();

                 signIn(emailController.text, passwordController.text).then((value) async =>
                   {
                     if ( value != null){
                       cartModel.cookie = value,
                     await prefs.setString('cookie', value),
                       Navigator.of(context).push(
                       MaterialPageRoute(builder: (context) => MyAppBar()))
                 }
                   });

                 },
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Register now'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}