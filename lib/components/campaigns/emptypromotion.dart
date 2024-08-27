import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:merchant/helper/text/text-custom.dart';

Widget promotionEmpty(void Function()? onPressn) {
  return Align(
    alignment: Alignment.center,
    child: Column(
      children: [
        textSubtitleBold("นำคะแนนสะสมที่มีมาสร้างโปรโมชันต่อเลย!"),
        InkWell(
            onTap: onPressn,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              width: 112,
              height: 112,
              decoration: const BoxDecoration(
                  color: Color(0xFF5F6793),
                  borderRadius: BorderRadius.all(Radius.circular(360))),
              child: const Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image(
                        width: 64,
                        height: 64,
                        image: Svg('/image/anoouce.svg')),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image(
                        width: 37, height: 37, image: Svg('/image/add.svg')),
                  )
                ],
              ),
            ))
      ],
    ),
  );
}
