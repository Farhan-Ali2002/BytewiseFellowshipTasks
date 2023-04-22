import 'package:bytewise_5_advanceui/examples/shortcuts/cart_action_ui.dart';
import 'package:bytewise_5_advanceui/examples/typography/linechart.dart';
import 'package:flutter/material.dart';
import '../examples/typography/fonts_typography.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.orange),
                child: Text('WEEK 5 header')),
            ListTile(
              title: const Text('keyboard shortcuts'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Cart()));
              },
            ),
            ListTile(
              title: const Text('Fonts and Typography'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TypographyFonts()));
              },
            ),
            ListTile(
              title: const Text('Line chart'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LineChart()));
              },
            ),
            ListTile(
              title: const Text('Line chart'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LineChart()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("WEEK5"),
      ),
    );
  }
}
