import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant/components/campaigns/emptyproduct.dart';
import 'package:merchant/components/campaigns/emptypromotion.dart';
import 'package:merchant/components/campaigns/listpromotion.dart';
import 'package:merchant/components/campaigns/product.dart';
import 'package:merchant/components/historys/history.dart';
import 'package:merchant/components/menu/topmenu.dart';
import 'package:merchant/constant/colors.dart';
import 'package:merchant/dto/campaignDTO.dart';
import 'package:merchant/dto/promotionDTO.dart';
import 'package:merchant/helper/text/text-custom.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:merchant/screens/create-promotion.dart';
import 'package:merchant/screens/point-qr.dart';
import 'package:merchant/screens/update-point.dart';
import 'package:merchant/common/textcustom.dart';

class CampaignDetail extends StatefulWidget {
  const CampaignDetail({super.key, required this.collectionId});

  final String collectionId;

  @override
  State<CampaignDetail> createState() =>
      _CampaignDetail(collectionId: collectionId);
}

class _CampaignDetail extends State<CampaignDetail> {
  _CampaignDetail({required this.collectionId});
  final String collectionId;
  final int totalProduct = 1;
  final int totalPromotion = 1;
  int totalCampaign = 0;
  dynamic campaignsDetail = {};
  List promotions = [];
  int countPromotions = 0;

  final ScrollController _listController = ScrollController();

  Future<void> getCampaignDetail() async {
    final campaignDetailRef = FirebaseFirestore.instance
        .collection("points")
        .where('campaignId', isEqualTo: collectionId)
        .withConverter<CampaignsDTO>(
          fromFirestore: (snapshots, _) =>
              CampaignsDTO.fromJson(snapshots.data()!),
          toFirestore: (campaign, _) => campaign.toJson(),
        );
    campaignDetailRef.count().get().then((data) {
      final int? totalData = data.count;
      if (data.count != 0) {
        campaignDetailRef.get().then((value) {
          for (var element in value.docs) {
            var data = {
              'id': element.id,
              'pointId': element['pointId'],
              'pointImg': element['pointImg'],
              'amount': element['amount'],
              'campaignId': element['campaignId'],
            };
            setState(() {
              campaignsDetail = data;
              totalCampaign = totalData!;
            });
          }
        });
      } else {}
    });
  }

  Future<void> getPromotion() async {
    final promotionRef = FirebaseFirestore.instance
        .collection("promotions")
        .where('campaignId', isEqualTo: collectionId)
        .withConverter<PromotionDTO>(
          fromFirestore: (snapshots, _) =>
              PromotionDTO.fromJson(snapshots.data()!),
          toFirestore: (promotions, _) => promotions.toJson(),
        );
    promotionRef.count().get().then((data) {
      final int? totalData = data.count;
      if (data.count != 0) {
        promotionRef.get().then((value) {
          List promoList = [];
          for (var element in value.docs) {
            var data = {
              'id': element.id,
              'price': element['price'],
              'sub': element['sub'],
              'title': element['title'],
              'uid': element['uid'],
              'period': element['period'],
              'img': element['img'],
              'campaignId': element['campaignId'],
            };
            promoList.add(data);
          }
          ;
          setState(() {
            promotions = promoList;
            countPromotions = totalData!;
          });
        });
      } else {
        print("dont");
      }
    });
  }

  void getHistory() {}
  void getPromotionHistory() {}
  void goHistory() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const History()),
    );
  }

  @override
  void initState() {
    super.initState();
    getCampaignDetail();
    getPromotion();
  }

  Widget emptyProduct() {
    final double width = MediaQuery.of(context).size.width * 1;
    final double height = MediaQuery.of(context).size.height * 1 / 3;
    return emptyProductComponent(context, width, height, collectionId);
  }

  Widget topMenuWidget() {
    return topMenuComponent(context, "ชื่อร้าน", goHistory);
  }

  Widget menuWidget() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => UpdatePoint(
                      id: campaignsDetail['id'],
                      amount: campaignsDetail['amount'],
                      pointId: campaignsDetail['pointId'],
                      campaignId: campaignsDetail['campaignId'],
                      collectionId: "collectionId")),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * (10 / 100),
            decoration: const BoxDecoration(
                color: Color(0xFF1E2644),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Image(
                      width: 50, height: 50, image: Svg('/image/setting.svg')),
                  // textSubtitleBold("ปรับแต่งคะแนนสะสม")
                  Text("ปรับแต่งคะแนนสะสม", style: baseTextStyle)
                ],
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * (10 / 100),
          margin: const EdgeInsets.only(top: 16),
          decoration: const BoxDecoration(
              color: Color(0xFF1E2644),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => PointQr(
                          pointId: campaignsDetail['pointId'],
                        )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Image(
                      width: 50, height: 50, image: Svg('/image/qr-code.svg')),
                  Text(
                    "QR Code สะสมคะแนนสำหรับลูกค้า",
                    style: baseTextStyle,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget promotionWidget() {
    return Column(
      children: [
        Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: OutlinedButton(
                    onPressed: () {},
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * (15 / 100),
                      height: MediaQuery.of(context).size.height * (3 / 100),
                      child: Center(
                          child: Text(
                        "โปรโมชั่น",
                        style: getBaseTextStyle(BaseText.baseS18),
                      )),
                    )),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                CreatePromotion(campaignId: collectionId)),
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * (15 / 100),
                      height: MediaQuery.of(context).size.height * (3 / 100),
                      child: Center(child: textNormal("add")),
                    )),
              ),
            ),
          ],
        ),
        totalPromotion <= 0
            ? promotionEmpty(getPromotionHistory)
            : listPromotion(context, promotions.length, promotions)
      ],
    );
  }

  Widget listItems() {
    return Column(
      children: [
        productsComponents(context, campaignsDetail),
        /*MENU*/
        menuWidget(),
        /*Promotion*/
        promotionWidget()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.shortestSide;
    return MaterialApp(
      color: primaryColor,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: primaryColor,
          body: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  children: [
                    /*TOP*/
                    topMenuWidget(),
                    /*Body*/
                    totalCampaign == 0 ? emptyProduct() : listItems(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
