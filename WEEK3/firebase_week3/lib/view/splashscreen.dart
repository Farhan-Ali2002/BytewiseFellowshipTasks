import 'package:firebase_week3/firebase_services/splashservice.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splashServices splashscreen = splashServices();
  @override
  void initState() {
    super.initState();
    splashscreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Text(
      "Splashhhh..",
      style: TextStyle(fontSize: 40),
    )));
  }
}
