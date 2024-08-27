import 'package:flutter/material.dart';

enum BaseText { baseS24, baseS18, baseS24Bold, baseS18Bold }

TextStyle getBaseTextStyle(BaseText type) {
  switch (type) {
    case BaseText.baseS18:
      return const TextStyle(
        height: 0.5,
        color: Colors.white,
        fontFamily: "DBHeaventCond",
        fontSize: 18,
        fontWeight: FontWeight.normal,
      );
    case BaseText.baseS24:
      return const TextStyle(
        height: 0.5,
        color: Colors.white,
        fontFamily: "DBHeaventCond",
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
    case BaseText.baseS24Bold:
      return const TextStyle(
        height: 0.5,
        color: Colors.white,
        fontFamily: "DBHeaventCond",
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );
    case BaseText.baseS18Bold:
      return const TextStyle(
        height: 0.5,
        color: Colors.white,
        fontFamily: "DBHeaventCond",
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );
  }
}

TextStyle baseTextStyle = const TextStyle(
  height: 0.5,
  color: Colors.white,
  fontFamily: "DBHeaventCond",
  fontSize: 24,
  fontWeight: FontWeight.w700,
);
TextStyle baseTextStyleNormal = const TextStyle(
  height: 0.5,
  color: Colors.white,
  fontFamily: "DBHeaventCond",
  fontSize: 18,
  fontWeight: FontWeight.w700,
);
