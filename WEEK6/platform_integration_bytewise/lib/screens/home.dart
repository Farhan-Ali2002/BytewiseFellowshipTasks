import 'package:flutter/material.dart';
import 'battery.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            title: const Text("Battery"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Battery()));
            },
          )
        ],
      )),
      appBar: AppBar(
        title: const Text("Platform Integration"),
      ),
    );
  }
}
