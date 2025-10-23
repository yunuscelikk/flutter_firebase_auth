import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/auth_service.dart';
import 'package:flutter_firebase_auth/components/my_button.dart';
import 'package:flutter_firebase_auth/components/my_text_field.dart';
import 'package:flutter_firebase_auth/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  String errorMessage = "";

  // @override
  // void dispose() {
  //   controllerEmail.dispose();
  //   controllerPassword.dispose();
  //   super.dispose();
  // }
  goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
  );
  void register() async {
    try {
      await authService.value.createAccount(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
      log('User created');
      goToHome(context);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "There is an error";
      });
      print(e.message);
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create your account",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(child: Icon(Icons.key, size: 50, color: Colors.amber)),
                SizedBox(height: 25),
                MyTextField(
                  controller: controllerEmail,
                  labelText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: controllerPassword,
                  labelText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: controllerConfirmPassword,
                  labelText: "Confirm Password",
                  obscureText: true,
                ),
                Text(errorMessage, style: TextStyle(color: Colors.redAccent)),
                const SizedBox(height: 15),
                MyButton(
                  text: "Sign Up",
                  backgroundColor: Colors.greenAccent[400],
                  onPressed: () {
                    register();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
