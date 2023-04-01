import 'package:flutter/material.dart';
import 'dart:async';
import '../view/auth/Loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../view/posts/postscreen.dart';

class splashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Postscreen())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())));
    }
  }
}
