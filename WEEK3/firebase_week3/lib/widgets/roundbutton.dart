import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onTap;
  const RoundButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white)),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    semanticsLabel: "....",
                    strokeWidth: 2.0,
                  )
                : Text(
                    title,
                    style: const TextStyle(color: Colors.white),
                  )),
      ),
    );
  }
}
