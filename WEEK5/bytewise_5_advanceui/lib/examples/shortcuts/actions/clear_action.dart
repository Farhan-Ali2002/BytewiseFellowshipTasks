import 'package:flutter/material.dart';

class ClearIntent extends Intent {
  const ClearIntent();
}

class ClearAction extends Action<ClearIntent> {
  ClearAction(this.clearController);
  final TextEditingController clearController;

  @override
  void invoke(covariant ClearIntent intent) => clearController.clear();
}
