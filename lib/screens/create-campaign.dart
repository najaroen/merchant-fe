import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant/common/default-button.dart';
import 'package:merchant/screens/campaign.dart';
import 'package:merchant/screens/create-success.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class CreateCampaign extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateCampaignState();
}

class _CreateCampaignState extends State<CreateCampaign> {
  final String coverImg =
      "https://img.freepik.com/free-photo/refreshing-pint-frothy-beer-wooden-bar-counter-generated-by-artificial-intelligence_188544-240946.jpg?t=st=1721371526~exp=1721375126~hmac=676d85da05baf43fc182749c57efc395006e7887e5184fa9aa8ccbf9ba88fe03&w=2000";

  TextEditingController _controller = new TextEditingController();
  TextEditingController _controllerDescription = new TextEditingController();

  Future<void> randomImge() async {
    var url = Uri.https(
        'https://api.unsplash.com/search/photos/?client_id=azo0Q5TcuAMajOgRbMSh4nG-p2VfkbBPIMukoueaQ0k&query=thaifood');
  }

  @override
  void initState() {
    super.initState();
    _controller.text = 'Freshing beer อร่อยสดชื่น';
    _controllerDescription.text =
        'UME Beer หอมกลิ่นบ๊วย เปรี้ยวนิด หวานหน่อยลงตัว';
  }

  Future<void> createCampaign() async {
    Stream<User?> users = FirebaseAuth.instance.authStateChanges();
    final data = await users.first;
    if (data != null) {
      String? uid = data?.uid;

      FirebaseFirestore.instance.collection("campaigns").add({
        'img': coverImg,
        'score': 5,
        'title': _controller.text,
        'sub': _controllerDescription.text,
        'uid': uid
      }).then((onValue) {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => CreateSuccess()),
        );
      }).catchError((onError) {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => Campaign()),
        );
      });
    } else {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => Campaign()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFF1E2644),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 48, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "สร้างร้านค้า",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                  Text(
                    "",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Container(
                  padding: EdgeInsets.all(8), // Border width
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: SizedBox.fromSize(
                      // size: Size.fromRadius(48), // Image radius
                      child: Image.network(
                          // height: 176,
                          coverImg,
                          fit: BoxFit.cover),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(left: 24, top: 24),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Text(
                    "ชื่อร้านค้า",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "DBHeaventCond",
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: TextFormField(
                controller: _controller,
                // initialValue: "Freshing beer อร่อยสดชื่น",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "DBHeaventCond",
                    fontSize: 20),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, top: 24),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Text(
                    "คำอธิบายร้านค้า",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "DBHeaventCond",
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: TextFormField(
                controller: _controllerDescription,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "DBHeaventCond",
                    fontSize: 20),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
              child: Column(
                children: [
                  CustomButtton(
                    title: "สร้างร้านค้า",
                    onPresseds: () async {
                      createCampaign();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
