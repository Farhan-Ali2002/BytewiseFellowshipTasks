import 'package:bytewise_week4_animations/example/circular.dart';
import 'package:bytewise_week4_animations/example/simple.dart';
import 'package:flutter/material.dart';
import 'example/d3.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            style: ListTileStyle.drawer,
            title: const Text("3D Animation screen"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ThreeD()));
            },
          ),
          ListTile(
            style: ListTileStyle.drawer,
            title: const Text("Circular Animation screen"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Circular()));
            },
          ),
          ListTile(
            style: ListTileStyle.drawer,
            title: const Text("Simple Animation screen"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SimpleAnimation()));
            },
          )
        ],
      )),
      appBar: AppBar(
        title: const Text("Animation"),
      ),
    );
  }
}
