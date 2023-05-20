import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(
      {super.key, required this.mobileViewWidget, required this.webViewWidget});
  final Widget webViewWidget;
  final Widget mobileViewWidget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return webViewWidget;
        //webview
      } else {
        return mobileViewWidget;
      }
    });
  }
}
