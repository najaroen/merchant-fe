import 'package:flutter/material.dart';

class CustomButtton extends StatelessWidget {
  const CustomButtton(
      {super.key, required this.onPresseds, required this.title});

  final void Function() onPresseds;
  final String title;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 1 * (90 / 100);
    return OutlinedButton(
        onPressed: onPresseds,
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF1973F7)),
            minimumSize: WidgetStatePropertyAll(Size(width, 56)),
            padding:
                WidgetStatePropertyAll(EdgeInsets.only(top: 16, bottom: 16)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                side: BorderSide(width: 0.0, color: Color(0xFF1973F7))))),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              fontFamily: "DBHeaventCond",
              fontStyle: FontStyle.normal),
        ));
  }
}
