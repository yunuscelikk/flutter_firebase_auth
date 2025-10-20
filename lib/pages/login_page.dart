import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/auth_service.dart';
import 'package:flutter_firebase_auth/components/my_button.dart';
import 'package:flutter_firebase_auth/components/my_text_field.dart';
import 'package:flutter_firebase_auth/pages/home_page.dart';
import 'register_page.dart';

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

  void signIn() async {
    try {
      final user = await authService.value.signIn(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
      if (user != null) {
        log('User logged in');
        goToHome(context);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "There is an error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Icon(
                    Icons.lock,
                    size: 50,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  "Login to your account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 25),
                MyTextField(
                  controller: controllerEmail,
                  obscureText: false,
                  labelText: "Email",
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: controllerPassword,
                  obscureText: true,
                  labelText: "Password",
                ),
                const SizedBox(height: 20),
                MyButton(
                  onPressed: () {
                    signIn();
                  },
                  text: "Sign In",
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                SizedBox(height: 15),
                Text(errorMessage, style: TextStyle(color: Colors.redAccent)),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text("Dont have account?"),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),
                MyButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  text: "Sign Up",
                  backgroundColor: Colors.deepPurple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
