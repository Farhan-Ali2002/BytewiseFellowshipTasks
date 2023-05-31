import 'package:flutter/material.dart';
import 'package:my_instagram_clone/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout(
      {super.key, required this.mobileViewWidget, required this.webViewWidget});
  final Widget webViewWidget;
  final Widget mobileViewWidget;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  void addData() {
    UserProvider userProvider = Provider.of(context, listen: false);
    userProvider.RefreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return widget.webViewWidget;
        //webview
      } else {
        return widget.mobileViewWidget;
      }
    });
  }
}
