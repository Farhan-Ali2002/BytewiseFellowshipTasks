import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'view/splashscreen.dart';
import 'widgets/dismisskeyboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
