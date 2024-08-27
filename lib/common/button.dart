import 'package:flutter/material.dart';

class ButtonDefaultCustom extends StatelessWidget {
  const ButtonDefaultCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Color(0xFFC02021),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        height: 28,
        width: 56,
        child: const Center(
          child: Text(
            "Beta",
            style: TextStyle(color: Colors.white, fontSize: 10.0),
          ),
        ));
  }
}
