import 'package:firebase_week3/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/Loginscreen.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post screen"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  utils().showToastMsg("Logout successfull");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }).onError((error, stackTrace) {
                  utils().showToastMsg(error.toString());
                });
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
    );
  }
}
