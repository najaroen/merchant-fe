import 'package:flutter/material.dart';

class HomeLogo extends StatelessWidget {
  const HomeLogo({super.key, required this.img});
  final String img;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 448,
      child: Image.asset(img)
    );
  }
}
