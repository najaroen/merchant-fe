import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:merchant/common/button.dart';
import 'package:merchant/constant/home-logo.dart';
import 'package:merchant/screens/register-step1.dart';

import '../common/default-button.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  void _goRegisterPage() {
    Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const RegisterStep1()),
            );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 1;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding:  EdgeInsets.only(
            top: 50,
            left: 0,
            right: 0,
          ),
          width: width,
          // color: Colors.amber,
                    color: Color(0xFF0F1630),
          child:  Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text("ddd"), Text("ddd"), ButtonDefaultCustom()]),
              Image(
                  width: 200,
                  height: 200,
                  image: Svg('/image/merchant-logo.svg')),
              Text("MERCHANT",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: "DBHeaventCond",
                      fontStyle: FontStyle.normal)),
              Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text("สร้างโปรโมชันให้ลูกค้าสะสมแต้ม",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DBHeaventCond",
                          fontStyle: FontStyle.normal))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeLogo(
                    img: "/image/home-1.png",
                  ),
                  HomeLogo(
                    img: "/image/home-2.png",
                  ),
                ],
              ),
                CustomButtton(
                  onPresseds: _goRegisterPage,
                  title: "ยืนยัน",                )         ],
          ),
        ),
      ),
    );
  }
}
