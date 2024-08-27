import 'package:flutter/material.dart';
import 'package:merchant/helper/text/text-custom.dart';

Widget productsComponents(BuildContext context, dynamic campaignsDetail) {
  return Column(
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
                child: Center(child: textNormal("คะแนนสะสม")),
              )),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * (20 / 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * (40 / 100),
              height: MediaQuery.of(context).size.height,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 90,
                  height: 112,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFF543434), width: 3),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: const Color(0xFFF9EACD)),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF508C6D),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        border: Border.all(
                            color: const Color(0xFF543434), width: 2.5),
                      ),
                      width: 50,
                      height: 50,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 70,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6)),
                                  color: Color(0xFF43CD8E)),
                            ),
                          ),
                          Image.network(
                            campaignsDetail['pointImg'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * (40 / 100),
              height: MediaQuery.of(context).size.height,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: textSubtitle("จำนวนคงเหลือ"),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child:
                                  textSubtitleBold(campaignsDetail['amount']),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: textSubtitle("จำนวนที่ลูกค้าได้รับ"),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: textSubtitleBold("0"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}
