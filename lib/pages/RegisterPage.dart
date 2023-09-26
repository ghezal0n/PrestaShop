import 'package:flutter/material.dart';
import '../components/my_Button.dart';
import '../components/my_textfield.dart';
import '../components/square_title.dart';
import 'LoginPage.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  // sign user in method
  void signIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: 'lib/images/download.jpg'),

                  SizedBox(width: 25),
                ],
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false, labelText: '', labelStyle: '',
              ),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true, labelText: '', labelStyle: '',
              ),

              MyTextField(
                controller: firstnameController,
                hintText: 'Firstname',
                obscureText: true,labelText: '', labelStyle: '',
              ),

              MyTextField(
                controller: lastnameController,
                hintText: 'Lastname',
                obscureText: true,labelText: '', labelStyle: '',
              ),

              const SizedBox(height: 10),

              // sign in button
              MyButton(
                onTap: signIn,
              ),

              const SizedBox(height: 25),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Login now'),
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