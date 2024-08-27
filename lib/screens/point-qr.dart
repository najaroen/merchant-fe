import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:merchant/common/default-button.dart';

import 'package:merchant/helper/text/text-custom.dart';
import 'package:merchant/screens/register-step1.dart';
import 'package:merchant/screens/show-qr.dart';

class PointQr extends StatefulWidget {
  const PointQr({super.key, required this.pointId});
  final String pointId;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PointQrState(pointId: pointId);
  }
}

class PointQrState extends State<PointQr> {
  PointQrState({required this.pointId});
  final String pointId;
  TextEditingController _controller = new TextEditingController();
  var qrsList = <dynamic>[];
  Future<void> generateQrPoint() async {
    Stream<User?> users = FirebaseAuth.instance.authStateChanges();
    final data = await users.first;
    if (data != null) {
      String? uid = data?.uid;
      FirebaseFirestore.instance.collection("pointsQr").add({
        'pointId': pointId,
        'amount': _controller.text,
        'uid': uid
      }).then((onValue) {
        Navigator.pop(context);
      }).catchError((onError) {
        print(onError);
        Navigator.pop(context);
      });
    } else {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => RegisterStep1()),
      );
    }
    await getQRcodeList();
    setState(() {
      _controller.text = '';
    });
  }

  Future<void> getQRcodeList() async {
    var qrs = <dynamic>[];
    final qrRef = FirebaseFirestore.instance
        .collection("pointsQr")
        .where('pointId', isEqualTo: pointId)
        .withConverter<QRPointDTO>(
          fromFirestore: (snapshots, _) =>
              QRPointDTO.fromJson(snapshots.data()!),
          toFirestore: (qr, _) => qr.toJson(),
        );
    qrRef.get().then((value) {
      for (var element in value.docs) {
        qrs.add({
          'amount': element['amount'],
          'pointId': element['pointId'],
          'uid': element['uid']
        });
      }
      setState(() {
        qrsList = qrs;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getQRcodeList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFF0f1630),
      body: ListView(
        padding: EdgeInsets.only(top: 36, left: 24, right: 24),
        children: [
          Row(
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
                      child: textSubtitle("QR Code สะสมคะแนนสำหรับลูกค้า"),
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
          ),
          Container(
            padding: EdgeInsets.all(8), // Border width
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: SizedBox.fromSize(
                // size: Size.fromRadius(48), // Image radius
                child: Image.asset('/icon/icon_qr_code64.png',
                    width: 180, height: 180, fit: BoxFit.contain),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: OutlinedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   CupertinoPageRoute(
                    //       builder: (context) =>
                    //           CreatePromotion(campaignId: collectionId)),
                    // );
                  },
                  child: Center(
                    child: textNormal("QR คะแนนสะสม"),
                  )),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * (8 / 100),
            child: InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                              controller: _controller,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "DBHeaventCond",
                                  fontSize: 20),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: CustomButtton(
                                title: "ยืนยัน",
                                onPresseds: () async {
                                  await generateQrPoint();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    color: Color(0xFF1E2644),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Center(
                  child: Image(
                      width: 30, height: 30, image: Svg('/image/add.svg')),
                ),
              ),
            ),
          ),
          Column(
            children: List.generate(qrsList.length, (index) {
              return Container(
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: Color(0xFF1E2644),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Image.asset(
                            width: 30,
                            height: 30,
                            '/icon/icons8-scan-50-white.png',
                          ),
                          Text(
                            "${qrsList[index]['amount']} คะแนน",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "DBHeaventCond"),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // ShowQR
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ShowQR(
                                    title:
                                        "QR คะแนนสะสม ${qrsList[index]['amount']} คะแนน",
                                    amount: qrsList[index]['amount'],
                                    pointId: qrsList[index]['pointId'],
                                  )),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

@immutable
class QRPointDTO {
  const QRPointDTO(
      {required this.amount, required this.pointId, required this.uid});

  QRPointDTO.fromJson(Map<String, Object?> json)
      : this(
            amount: json['amount']! as String,
            pointId: json['pointId']! as String,
            uid: json['uid']! as String);

  final String amount;
  final String pointId;
  final String uid;
  Map<String, Object?> toJson() {
    return {'amount': amount, 'pointId': pointId, 'uid': uid};
  }
}
