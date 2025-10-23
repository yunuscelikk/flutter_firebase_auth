import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/auth_service.dart';
import 'package:flutter_firebase_auth/components/my_button.dart';
import 'package:flutter_firebase_auth/components/my_text_field.dart';
import 'package:flutter_firebase_auth/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String errorMessage = "";

  goToHome(BuildContext context) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
  );

  final _formKey = GlobalKey<FormState>();

  void signIn() async {
    try {
      await authService.value.signIn(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
      log('User logged in');
      goToHome(context);
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException: ${e.code}");
      setState(() {
        if (e.code == 'user-not-found' ||
            e.code == 'wrong-password' ||
            e.code == 'invalid-credential') {
          errorMessage = 'Email or password incorrect';
        } else {
          errorMessage = 'Login failed. Try again';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 27, 13),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    child: Icon(Icons.key, size: 50, color: Colors.amber),
                  ),
                  SizedBox(height: 25),
                  MyTextField(
                    controller: controllerEmail,
                    obscureText: false,
                    labelText: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Email required";
                      if (!RegExp(
                        r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return "Invalid email format";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: controllerPassword,
                    obscureText: true,
                    labelText: "Password",
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Password required";
                      if (value.length < 6) return "Minimum 6 characters";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) signIn();
                    },
                    text: "Sign In",
                    backgroundColor: Colors.greenAccent[400],
                  ),
                  SizedBox(height: 15),
                  Text(errorMessage, style: TextStyle(color: Colors.redAccent)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
