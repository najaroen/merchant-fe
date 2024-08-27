import 'package:flutter/material.dart';
import 'package:merchant/common/textcustom.dart';
import 'package:merchant/components/menu/topmenu.dart';
import 'package:merchant/constant/colors.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

enum statusActive { ACTIVE_POINT, ACTIVE_PROMOTION }

enum statusScore { ACTIVE_SYSTEM, ACTIVE_OUR_CUSTOMER }

class _HistoryState extends State<History> {
  bool activePoint = true;
  bool activePromotion = false;

  bool activeSys = true;
  bool activeSysCustomer = false;

  void isActive(statusActive status) {
    switch (status) {
      case statusActive.ACTIVE_POINT:
        setState(() {
          activePoint = true;
          activePromotion = false;
        });
      case statusActive.ACTIVE_PROMOTION:
        setState(() {
          activePoint = false;
          activePromotion = true;
        });
    }
  }

  void isActiveScore(statusScore status) {
    switch (status) {
      case statusScore.ACTIVE_SYSTEM:
        setState(() {
          activeSys = true;
          activeSysCustomer = false;
        });
      case statusScore.ACTIVE_OUR_CUSTOMER:
        setState(() {
          activeSys = false;
          activeSysCustomer = true;
        });
    }
  }

  void getData() async {
    // var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    // print(response.body);
  }
  Widget pointScoreWidget() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
              margin: const EdgeInsets.only(top: 16, left: 0),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("คะแนนสะสมทั้งหมด",
                        style: getBaseTextStyle(BaseText.baseS24Bold)),
                  ),
                  Text("12,000", style: getBaseTextStyle(BaseText.baseS18))
                ],
              )),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("คะแนนสะสมที่ลูกค้าได้รับ",
                        style: getBaseTextStyle(BaseText.baseS24Bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("12,000",
                        style: getBaseTextStyle(BaseText.baseS18)),
                  ),
                ],
              )),
        )
      ],
    );
  }

  Widget promotionWidget() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 36),
        child: ListView(
          children: [
            topMenuComponent(context, "ประวัติการทำรายการ", getData),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      isActive(statusActive.ACTIVE_POINT);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          color: activePoint
                              ? const Color(0xff1e2744)
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          border: Border.all(
                              color: activePoint
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 1)),
                      child: Center(
                        child: Text(
                          "คะแนนสะสม",
                          style: getBaseTextStyle(BaseText.baseS18),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      isActive(statusActive.ACTIVE_PROMOTION);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, top: 24),
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          color: activePromotion
                              ? const Color(0xff1e2744)
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          border: Border.all(
                              color: activePromotion
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 1)),
                      child: Center(
                        child: Text(
                          "โปรโมชั่น",
                          style: getBaseTextStyle(BaseText.baseS18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            activePoint
                ? pointScoreWidget()
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
            activePromotion
                ? promotionWidget()
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        isActiveScore(statusScore.ACTIVE_SYSTEM);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 16),
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: activeSys
                                ? const Color(0xff1e2744)
                                : Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            border: Border.all(
                                color: activeSys
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 1)),
                        child: Center(
                          child: Text(
                            "ระบบ",
                            style: getBaseTextStyle(BaseText.baseS18),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        isActiveScore(statusScore.ACTIVE_OUR_CUSTOMER);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 8, top: 16),
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: activeSysCustomer
                                ? const Color(0xff1e2744)
                                : Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            border: Border.all(
                                color: activeSysCustomer
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 1)),
                        child: Center(
                          child: Text(
                            "ข้อมูลลูกค้าของคุณ",
                            style: getBaseTextStyle(BaseText.baseS18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
