// import 'package:firebase_core_web/firebase_core_web_interop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:merchant/components/historys/history.dart';
// import 'package:merchant/common/button.dart';
import 'package:merchant/constant/colors.dart';
// import 'package:merchant/constant/home-logo.dart';
// import 'package:merchant/dto/campaign-dto.dart';
import 'package:merchant/helper/text/text-custom.dart';
import 'package:merchant/screens/create-campaign.dart';
import 'package:merchant/screens/register-step1.dart';
import 'package:merchant/wallet/metamaskService.dart';
import 'package:merchant/widget/app-bar-merchant.dart';
// import 'package:merchant/widget/campaign-list-view.dart';
import 'package:merchant/widget/empty-merchant.dart';
import 'package:merchant/widget/merchant-card.dart';
import 'package:web3dart/web3dart.dart';

// import '../common/default-button.dart';

class Campaign extends StatefulWidget {
  Campaign({super.key});

  @override
  State<Campaign> createState() => _Campaign();
}

class _Campaign extends State<Campaign> {
  List campaignsList = [];
  String amount = "";
  List initCampaigns() {
    List campaigns = [];
    FirebaseFirestore.instance.collection("campaigns").get().then((onValue) {
      // for (var val in onValue.docs) {
      //   Map<String, dynamic> result = val.data();
      // }
      campaigns.addAll(onValue.docs);
    });
    return campaigns;
  }

  Future<void> connectMetamask() async {
    try {
      var credentials =
          EthPrivateKey.fromHex("0x7c55259cc19af2ab5f417680884b5b642e20cdc4");
      var address = credentials.address;
      MetamaskService metamaskService = MetamaskService(address);
      EtherAmount result = await metamaskService.initMetamask();
      setState(() {
        amount = result.getInEther.toString();
      });
      print("==>" + amount);
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Campaigns>> getData() {
    final valueList = FirebaseFirestore.instance
        .collection("campaigns")
        .withConverter<Campaigns>(
          fromFirestore: (snapshots, _) =>
              Campaigns.fromJson(snapshots.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );
    // .withConverter
    return valueList.snapshots();
  }

  @override
  initState() {
    super.initState();
    connectMetamask();
    var campaigns = <dynamic>[];
    final campaignRef = FirebaseFirestore.instance
        .collection("campaigns")
        .withConverter<Campaigns>(
          fromFirestore: (snapshots, _) =>
              Campaigns.fromJson(snapshots.data()!),
          toFirestore: (campaign, _) => campaign.toJson(),
        );
    campaignRef.get().then((value) {
      for (var element in value.docs) {
        campaigns.add({
          'collectionId': element.id,
          'title': element['title'],
          'sub': element['sub'],
          'score': element['score'],
          'img': element['img'],
          'uid': element['uid']
        });
      }
      setState(() {
        campaignsList = campaigns;
      });
    });
  }

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

  int total = 10;

  Widget RenderEmpty(double h) {
    return Container(
      width: 192,
      height: 192,
      margin: EdgeInsets.only(top: h),
      decoration: BoxDecoration(
          color: grayColor,
          borderRadius: BorderRadius.all(Radius.circular(360))),
      child: EmptyMerchant(),
    );
  }

  List<Widget> EventList(double height) {
    return [
      AppBarMerchant(amout: amount),
      Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                  onPressed: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height * (3 / 100),
                    child: Center(child: textNormal("ร้านค้าของฉัน")),
                  )),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => CreateCampaign()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF1E2644),
                      borderRadius: BorderRadius.all(Radius.circular(360))),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image(
                            width: 30,
                            height: 30,
                            image: Svg('/image/icon-merchant.svg')),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF1E2644),
                            borderRadius:
                                BorderRadius.all(Radius.circular(360))),
                        margin: EdgeInsets.only(top: 12.0, left: 15.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image(
                              width: 20,
                              height: 20,
                              image: Svg('/image/add.svg')),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        // height: height,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Container(
          child: Column(
            children: List.generate(campaignsList.length, (index) {
              return MerchantCard(
                  collectionId: campaignsList[index]['collectionId'],
                  title: campaignsList[index]['title'],
                  description: campaignsList[index]['sub'],
                  pathImg: campaignsList[index]['img']);
            }),
          ),
        ),
      ),
    ];
  }

  List<Widget> EmptyList = [
    AppBarMerchant(
      amout: "00",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 1;
    double height = MediaQuery.of(context).size.height * 1 / 3;
    return MaterialApp(
      color: primaryColor,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: primaryColor,
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: total <= 0 ? EmptyList : EventList(height),
          )),
    );
  }
}

@immutable
class Campaigns {
  Campaigns(
      {required this.title,
      required this.sub,
      required this.img,
      required this.score,
      required this.collectionId});

  Campaigns.fromJson(Map<String, Object?> json)
      : this(
          sub: json['sub']! as String,
          img: json['img']! as String,
          title: json['title']! as String,
          score: json['score']! as int,
          collectionId: json['collectionId']! as String,
        );

  final String sub;
  final String img;
  final String title;
  final int score;
  final String collectionId;

  Map<String, Object?> toJson() {
    return {
      'sub': sub,
      'img': img,
      'title': title,
      'score': score,
      'collectionId': collectionId
    };
  }
}
