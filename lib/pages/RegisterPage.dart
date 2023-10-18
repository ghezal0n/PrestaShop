import 'dart:convert';

import 'package:flutter/material.dart';
import '../components/my_Button.dart';
import '../components/my_textfield.dart';
import '../components/square_title.dart';
import 'LoginPage.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  Future<String?> signUp(
      String email, String password, String firstName, String lastName) async {
    final Uri url = Uri.https('rest.binshops.com', 'rest/register');

    final response = await http.post(
      url,
      headers: {"Access-Control-Allow-Origin": "*"},
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
      }),
    );

    if (response.statusCode == 200) {
      //nevLog
      print("22");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginPage()));
      return "Done";
    } else {
      return "Error. statusCode : ${response.statusCode}";
    }
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      signUp(
        emailController.text,
        passwordController.text,
        firstnameController.text,
        lastnameController.text,
      ).then((result) {
        if (result == "Done") {
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(result ?? "An error has occurred during registration"),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: "assets/image/Logo.png"),


                  ],
                ),

                const SizedBox(height: 15),

                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  labelText: '',
                  labelStyle: '',
                  /*validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez entrer une adresse email';
                    } else if (!value.contains('@')) {
                      return 'Veuillez entrer une adresse email valide';
                    }
                    return null;
                  },*/
                ),

                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  labelText: '',
                  labelStyle: '',
                 /* validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez entrer un mot de passe';
                    } else if (value.length < 6) {
                      return 'Le mot de passe doit comporter au moins 6 caractères';
                    }
                    return null;
                  },*/
                ),

                MyTextField(
                  controller: firstnameController,
                  hintText: 'Firstname',
                  obscureText: false,
                  labelText: '',
                  labelStyle: '',
                  /*validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez entrer votre prénom';
                    }
                    return null;
                  },*/
                ),

                MyTextField(
                  controller: lastnameController,
                  hintText: 'Lastname',
                  obscureText: false,
                  labelText: '',
                  labelStyle: '',
                  /*validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez entrer votre nom';
                    }
                    return null;
                  },*/
                ),



                /* MyButton(
                   onTap: () async {
                     String? result = await signUp(
                       emailController.text,
                       passwordController.text,
                       firstnameController.text,
                       lastnameController.text,
                     );

                     if (result == "Done") {
                       // Faites quelque chose en cas de succès

                       //_handleSignUp
                     } else {
                       showDialog(
                         context: context,
                         builder: (BuildContext context) {
                           return AlertDialog(
                             title: Text("Error"),
                             content: Text("An error has occurred : $result"),
                             actions: [
                               TextButton(
                                 onPressed: () {
                                   Navigator.of(context).pop();
                                 },
                                 child: Text("OK"),
                               ),
                             ],
                           );
                         },
                       );
                     }
                   },
                   //onTap: signUp(emailController.text,passwordController.text,firstnameController.text,lastnameController.text),
              ),*/

                /*MyButton(
                  onTap: _handleSignUp, // Appeler la fonction de gestion de l'inscription
                ),*/

                const SizedBox(height: 10),

                MyButton(
                  onTap: () {
                    signUp(emailController.text, passwordController.text, firstnameController.text, lastnameController.text);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginPage()));
                  },
                ),
                // not a member? register now
              ],
            ),
          ),
        ),
      ),
    );
  }
}
