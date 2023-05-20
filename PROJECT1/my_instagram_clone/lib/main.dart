import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './utils/colors.dart';
// import './responsive/responsive_layout_screen.dart';
// import './responsive/mobile_screen_layout.dart';
// import './responsive/webs_screen_layout.dart';
import './screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyAFYWwMBbtG6cMUhgwCfKyO00KWyIJgJjg",
      appId: "1:69859643497:web:859fcced591a545bfa12f8",
      messagingSenderId: "69859643497",
      projectId: "instagram-clone-fa6cf",
      storageBucket: "instagram-clone-fa6cf.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Instagram Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: const Scaffold(
          // body: ResponsiveLayout(
          //     mobileViewWidget: MobileViewWidget(),
          //     webViewWidget: WebViewWidget())),
          body: LoginScreen(),
        ));
  }
}
