import 'package:flutter/material.dart';

class incrementIntent extends Intent {
  const incrementIntent();
}

// class incrementAction extends Action<incrementIntent> {
//   incrementAction(this.incrementController);
//   final TextEditingController incrementController;

//   @override
//   void invoke(covariant incrementIntent intent) {
//     int num = int.parse(incrementController.text);
//     if (num >= 0) {
//       num += 1;
//       incrementController.text = num.toString();
//     }
//   }
// }
