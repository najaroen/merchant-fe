import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:merchant/helper/text/text-custom.dart';
import 'package:merchant/screens/create-point.dart';

Widget emptyProductComponent(
    BuildContext context, double width, double height, String collectionId) {
  return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1 / 3,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 1 / 7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width * (12 / 100)),
                  child: textTitle("สร้างคะแนนสะสมประจำร้านค้าของคุณ"),
                ),
              ),
            ],
          ),
          InkWell(
              // TODO: put collectionId
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => CreatePoint(
                            collectionId: collectionId,
                          )),
                );
              },
              child: Container(
                width: 192,
                height: 192,
                decoration: const BoxDecoration(
                    color: Color(0xFF5F6793),
                    borderRadius: BorderRadius.all(Radius.circular(360))),
                child: const Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image(
                          width: 120,
                          height: 120,
                          image: Svg('/image/point-card.svg')),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image(
                          width: 60, height: 60, image: Svg('/image/add.svg')),
                    )
                  ],
                ),
              )),
        ],
      ));
}
