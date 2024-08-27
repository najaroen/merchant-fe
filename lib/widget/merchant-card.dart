import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant/helper/text/text-custom.dart';
import 'package:merchant/screens/campaign-detail.dart';
import 'package:merchant/screens/register-step1.dart';

class MerchantCard extends StatelessWidget {
  MerchantCard(
      {super.key,
      required this.title,
      required this.description,
      required this.collectionId,
      required this.pathImg});

  final String title;
  final String pathImg;
  final String description;
  final String collectionId;

  Widget renderCardCover(String img) {
    return Container(
      padding: EdgeInsets.all(8), // Border width
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: SizedBox.fromSize(
          // size: Size.fromRadius(48), // Image radius
          child: Image.network(img, fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => CampaignDetail(
                    collectionId: collectionId,
                  )),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          children: [
            renderCardCover(pathImg),
            Padding(
              padding: EdgeInsets.only(top: 1, left: 10, right: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: textTitle(title),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber.shade300,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber.shade300,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber.shade300,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber.shade300,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1, left: 10, right: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: textSubtitle(description),
              ),
            )
          ],
        ),
      ),
    );
  }
}
