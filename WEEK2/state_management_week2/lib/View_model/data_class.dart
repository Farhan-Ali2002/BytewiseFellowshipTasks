import 'package:flutter/material.dart';

class DataClass extends ChangeNotifier {
  int _shoes = 0;

  int get shoes => _shoes;

  void incrementShoe() {
    _shoes++;
    notifyListeners();
  }

  void decrementShoe() {
    _shoes--;
    notifyListeners();
  }
}
