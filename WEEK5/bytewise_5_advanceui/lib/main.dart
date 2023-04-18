import 'package:bytewise_5_advanceui/actions/clear_action.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController clearController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        ClearIntent: ClearAction(clearController)
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text("Advanced UI")),
          body: Container(
            decoration: const BoxDecoration(),
            height: 400,
            width: 400,
            child: Card(
              color: const Color.fromARGB(255, 36, 35, 35),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: clearController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 255, 252, 252),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 252, 252))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    width: 2,
                                    color: Color.fromARGB(255, 230, 228, 228))),
                            hintText: "Enter Text...",
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                    IconButton(
                        enableFeedback: true,
                        hoverColor: Colors.grey,
                        onPressed: () {
                          Actions.invoke<ClearIntent>(
                              context, const ClearIntent());
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
