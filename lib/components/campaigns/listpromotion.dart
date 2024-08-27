import 'package:flutter/material.dart';

Widget listPromotion(BuildContext context, int total, List promotions) {
  if (total == 0) {
    return const SizedBox();
  } else {
    return Column(
      children: List.generate(promotions.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          height: MediaQuery.of(context).size.height * (15 / 100),
          decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   stops: [0.0, 0.5, 1.0],
              //   colors: [
              //     Colors.blue,
              //     Colors.cyan,
              //     Colors.green,
              //   ],
              // ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // padding: EdgeInsets.all(8), // Border width
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    child: SizedBox.fromSize(
                      // size: Size.fromRadius(48), // Image radius
                      child: Image.network(promotions[index]['img'],
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Text(
                        promotions[index]['title'],
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                            height: 0.7,
                            color: Colors.white,
                            fontFamily: "DBHeaventCond",
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "จำนวน ${promotions[index]['quote']} ชุด",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Color(0xFFD0D0D0),
                                fontFamily: "DBHeaventCond",
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          )
                          // textNormal(
                          //     "จำนวน ${items[index]['total']} ชุด"),
                          ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "100 คะแนน",
                          style: TextStyle(
                              height: 1,
                              color: Color(0xFF0E6DFB),
                              fontFamily: "DBHeaventCond",
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Flex(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            direction: Axis.horizontal,
                            children: [
                              const Text(
                                "สิทธิ์คงเหลือ ",
                                style: TextStyle(
                                    height: 1,
                                    color: Color(0xFFD0D0D0),
                                    fontFamily: "DBHeaventCond",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "0/${promotions[index]['quote']}",
                                style: const TextStyle(
                                    height: 1,
                                    color: Colors.white,
                                    fontFamily: "DBHeaventCond",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )
                            ]),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Flex(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            direction: Axis.horizontal,
                            children: [
                              const Text(
                                "ใช้ได้ถึง ",
                                style: TextStyle(
                                    height: 1,
                                    color: Color(0xFFD0D0D0),
                                    fontFamily: "DBHeaventCond",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${promotions[index]['period']}}",
                                style: const TextStyle(
                                    height: 1,
                                    color: Colors.white,
                                    fontFamily: "DBHeaventCond",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              )
                            ]),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
