import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:merchant/common/default-button.dart';
// import 'package:merchant/common/loading.dart';
import 'package:merchant/constant/colors.dart';
import 'package:merchant/helper/text/text-custom.dart';
import 'package:merchant/screens/create-success.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:merchant/screens/point-card.dart';
import 'package:merchant/screens/register-step1.dart';

class CreatePoint extends StatefulWidget {
  CreatePoint({super.key, required this.collectionId});
  final String collectionId;
  @override
  State<StatefulWidget> createState() =>
      _CreatePointState(collectionId: collectionId);
}

class _CreatePointState extends State<CreatePoint> {
  _CreatePointState({required this.collectionId});
  final String collectionId;
  String selected = '';
  String imgpath = '';
  @override
  Widget build(BuildContext context) {
    List pastTips = [
      {
        'title': 'Love Busan',
        'sub': '3 months ago',
        'id': '1',
        'cover':
            'https://plus.unsplash.com/premium_photo-1661885506276-e5196a134c77?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      },
      {
        'title': 'London',
        'sub': '4 months ago',
        'id': '2',
        'cover':
            'https://images.unsplash.com/photo-1488747279002-c8523379faaa?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      },
      {
        'title': 'San francisco',
        'sub': '3 months ago',
        'id': '3',
        'cover':
            'https://images.unsplash.com/photo-1502285745115-13e43e3faad4?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      },
      {
        'title': 'Tokyo',
        'sub': '4 months ago',
        'id': '4',
        'cover':
            'https://images.unsplash.com/photo-1557348111-89ab5071b0a3?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      },
      {
        'title': 'New york city',
        'sub': '7 months ago',
        'id': '5',
        'cover':
            'https://images.unsplash.com/photo-1546436836-07a91091f160?q=80&w=2348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      },
      {
        'title': 'Singapore',
        'sub': '10 months ago',
        'id': '6',
        'cover':
            'https://images.unsplash.com/photo-1589848014442-5f540ff95bea?q=80&w=2368&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      },
      {
        'title': 'Bangkok',
        'sub': '1 year ago',
        'id': '7',
        'cover':
            'https://images.unsplash.com/photo-1586098311577-520120ba3df3?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      }
    ];
    TextEditingController _controller = new TextEditingController();

    Widget TopMenuWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: textSubtitle("สร้างคะแนนสะสม"),
                )
              ],
            ),
          ),
          Container(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.history_outlined),
              color: Colors.white,
            ),
          )
        ],
      );
    }

    void onSelectPoint() {}
    @override
    void initState() {
      super.initState();
      _controller.text = 'Freshing beer อร่อยสดชื่น';
    }

    Future<void> createPoint() async {
      Stream<User?> users = FirebaseAuth.instance.authStateChanges();
      final data = await users.first;
      if (data != null) {
        String? uid = data?.uid;
        FirebaseFirestore.instance.collection("points").add({
          'campaignId': collectionId,
          'amount': _controller.text,
          'pointImg': imgpath,
          'pointId': selected,
          'uid': uid
        }).then((onValue) {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => CreateSuccess()),
          );
        }).catchError((onError) {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => CreateSuccess()),
          );
        });
      } else {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => RegisterStep1()),
        );
      }
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24, top: 36, right: 24),
              child: TopMenuWidget(),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 26),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(pastTips.length, (index) {
                    return PointCard(
                        onSelected: () {
                          setState(() {
                            selected = pastTips[index]['id'];
                            imgpath = pastTips[index]['cover'];
                          });
                        },
                        id: pastTips[index]['id'],
                        selected: selected,
                        title: pastTips[index]['title'],
                        sub: pastTips[index]['sub'],
                        cover: pastTips[index]['cover']);
                  }),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, top: 24),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Text(
                    "จำนวนคะแนนสะสม",
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
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0, bottom: 2),
                    child: Text(
                      textAlign: TextAlign.left,
                      "Tips: คะแนนสะสมใช้ในการทำการตลาดเพื่อแจกจ่ายให้ลูกค้า",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  CustomButtton(
                    title: "ยืนยัน",
                    onPresseds: () async {
                      createPoint();
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
