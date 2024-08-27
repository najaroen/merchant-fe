import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:merchant/common/default-button.dart';
import 'package:merchant/screens/regsiter-step2.dart';
import 'package:web3dart/web3dart.dart';

class RegisterStep1 extends StatefulWidget {
  const RegisterStep1({super.key});
  @override
  State<RegisterStep1> createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {
  String? displayName = "";
  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
    // Once signed in, return the UserCredential
  }

  Future<void> connectWallet() async {}

  Future<void> toStep2() async {
    try {
      UserCredential users = await signInWithGoogle();
      displayName = users.user?.displayName;
      Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                const RegisterStep2(displayName: "xcscsacsa")),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 1;
    double height = MediaQuery.of(context).size.height * 1;
    double tops = MediaQuery.of(context).size.height * 1 / 3;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
              Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Image(
                    width: 150,
                    height: 150,
                    image: Svg('/image/icon-person.svg')),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Text(
                    "ชื่อของคุณ",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "DBHeaventCond",
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              TextFormField(
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "DBHeaventCond",
                    fontSize: 18),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: tops),
                  child: Column(
                    children: [
                      CustomButtton(
                        title: "ยืนยัน",
                        onPresseds: toStep2,
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
