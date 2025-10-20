import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/auth_service.dart';
import 'package:flutter_firebase_auth/pages/app_loading_page.dart';
import 'package:flutter_firebase_auth/pages/home_page.dart';
import 'package:flutter_firebase_auth/pages/login_page.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageIfNotConnected});

  final Widget? pageIfNotConnected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, authService, child) {
        Widget widget;
        return StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            Widget widget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              widget = AppLoadingPage();
            } else if (snapshot.hasData) {
              widget = const HomePage();
            } else {
              widget = pageIfNotConnected ?? const LoginPage();
            }
            return widget;
          },
        );
      },
    );
  }
}
