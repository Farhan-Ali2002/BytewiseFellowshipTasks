import 'package:flutter/material.dart';

import 'cart.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Shopping Cart"),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFFfefcff),
        body: Column(
          children: const [
            Cart(),
          ],
        ));
  }
}
