import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class AppBarMerchant extends StatelessWidget {
  const AppBarMerchant({super.key, required this.amout});
  final String amout;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: Color(0xFFE3E3E3),
                borderRadius: BorderRadius.all(Radius.circular(360)),
              ),
              child: GestureDetector(
                onTap: () {},
                child: Image(
                    width: 20,
                    height: 20,
                    image: Svg('/image/icon-person.svg')),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${amout} NXN",
                    style: TextStyle(
                        color: Color(0xFFF4F4F4),
                        fontFamily: "DBHeaventCond",
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    // margin:EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(360)),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image(
                          width: 50, height: 50, image: Svg('/image/edit.svg')),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(left: 1, right: 5),
              decoration: BoxDecoration(
                color: Color(0xFF3E3E3E),
                borderRadius: BorderRadius.all(Radius.circular(360)),
              ),
              child: GestureDetector(
                onTap: () {},
                child:
                    Image(width: 50, height: 50, image: Svg('/image/rank.svg')),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(left: 1, right: 1),
              decoration: BoxDecoration(
                color: Color(0xFF3E3E3E),
                borderRadius: BorderRadius.all(Radius.circular(360)),
              ),
              child: GestureDetector(
                onTap: () {},
                child: Image(
                    width: 50,
                    height: 50,
                    image: Svg('/image/notification.svg')),
              ),
            )
          ],
        ),
      ],
    );
  }
}
