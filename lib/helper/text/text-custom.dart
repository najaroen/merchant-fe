import 'package:flutter/material.dart';

Widget textTitle(String title) {
  return Text(
    title,
    style: TextStyle(
        color: Color(0xFFF4F4F4),
        fontFamily: "DBHeaventCond",
        fontSize: 28,
        fontWeight: FontWeight.w700),
  );
}

Widget textSubtitle(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Color(0xFFF4F4F4),
        fontFamily: "DBHeaventCond",
        fontSize: 24,
        fontWeight: FontWeight.w400),
  );
}

Widget textNormal(String text) {
  return Text(
    text,
    style: const TextStyle(
        // height: 1,
        color: Color(0xFFF4F4F4),
        fontFamily: "DBHeaventCond",
        fontSize: 18,
        fontWeight: FontWeight.w700),
  );
}

Widget textSubtitleBold(String text) {
  return Text(
    text,
    style: const TextStyle(
        height: 0.5,
        color: Colors.white,
        fontFamily: "DBHeaventCond",
        fontSize: 24,
        fontWeight: FontWeight.w700),
  );
}
