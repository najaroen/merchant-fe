import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:merchant/common/default-button.dart';
import 'package:merchant/screens/campaign.dart';

class RegisterStep2 extends StatefulWidget {
  const RegisterStep2({super.key, required this.displayName});
  final String? displayName;
  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  String userName = "";
  Future<void> doSome() async {
    Stream<User?> users = FirebaseAuth.instance.authStateChanges();
    final data = await users.first;
    // userName = data?.displayName;
    String? displayName = data?.displayName;
    setState(() {
      userName = displayName.toString();
    });
  }

  @override
  initState() {
    doSome();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 1;
    double height = MediaQuery.of(context).size.height * 1;
    double tops = MediaQuery.of(context).size.height * 1 / 4;

    return Scaffold(
      body: Container(
          color: Color(0xFF0F1630),
          width: width,
          height: height,
          padding:
              EdgeInsets.only(left: 24.0, top: 12.0, bottom: 24.0, right: 24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30, left: 7),
                        child: Image(
                            width: 150,
                            height: 150,
                            image: Svg('/image/merchant-logo.svg')),
                      ),
                      Text(
                        "MERCHANT",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "DBHeaventCond"),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 1 / 8),
              ),
              Text(
                "ยินดีต้อนรับ",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "DBHeaventCond",
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ยินดีต้อนรับ",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "DBHeaventCond",
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Padding(padding: EdgeInsets.only(left: 2, right: 2)),
                  Text(
                    userName,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "DBHeaventCond",
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 1 / 20),
                child: Image(
                    width: 150, height: 150, image: Svg('/image/bell.svg')),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: tops),
                  child: Column(
                    children: [
                      CustomButtton(
                        title: "เข้าสู่หน้าหลัก",
                        onPresseds: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Campaign()),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
