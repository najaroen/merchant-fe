import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
// import 'package:flutter/widgets.dart';
import 'package:merchant/common/default-button.dart';
// import 'package:merchant/common/loading.dart';
import 'package:merchant/constant/colors.dart';
import 'package:merchant/helper/text/text-custom.dart';
import 'package:merchant/screens/campaign.dart';
import 'package:merchant/screens/create-success.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
// import 'package:merchant/screens/point-card.dart';
import 'package:merchant/screens/register-step1.dart';
// ignore: library_prefixes
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

final today = DateUtils.dateOnly(DateTime.now());

class CreatePromotion extends StatefulWidget {
  CreatePromotion({super.key, required this.campaignId});

  final String campaignId;

  @override
  State<StatefulWidget> createState() =>
      _CreatePromotionState(campaignId: campaignId);
}

class _CreatePromotionState extends State<CreatePromotion> {
  _CreatePromotionState({
    required this.campaignId,
  });

  final String campaignId;
  String dateValue = 'วว/ดด/ปปปป - วว/ดด/ปปปป';
  String selected = '';
  String imgpath = '';
  String imgCover =
      "https://plus.unsplash.com/premium_photo-1683657860186-6afce5df3c0a?q=80&w=3542&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = list.first;
  final _scrollController = ScrollController();
  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime(2021, 8, 10),
    DateTime(2021, 8, 13),
  ];
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now().add(const Duration(days: 1)),
  ];
  List<DateTime?> _multiDatePickerValueWithDefaultValue = [
    DateTime(today.year, today.month, 1),
    DateTime(today.year, today.month, 5),
    DateTime(today.year, today.month, 14),
    DateTime(today.year, today.month, 17),
    DateTime(today.year, today.month, 25),
  ];
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime(1999, 5, 6),
    DateTime(1999, 5, 21),
  ];

  List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 5)),
  ];
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controllerSub = new TextEditingController();
  TextEditingController _controllerPrice = new TextEditingController();
  TextEditingController _controllerQuote = new TextEditingController();

  Future<void> updatePoint() async {
    Stream<User?> users = FirebaseAuth.instance.authStateChanges();
    final data = await users.first;
    if (data != null) {
      String? uid = data?.uid;
      FirebaseFirestore.instance.collection('promotions').add({
        'campaignId': campaignId,
        'title': _controller.text,
        'sub': _controllerSub.text,
        'price': _controllerPrice.text,
        'quote': _controllerQuote.text,
        'img': imgCover,
        'period': dateValue,
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
        CupertinoPageRoute(builder: (context) => RegisterStep1()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.text = "เจ๊โอว ข้าวต้มเป็ด";
    _controllerPrice.text = "300";
    _controllerSub.text = "อร่อยมาก";
    _controllerQuote.text = "1000";
  }

  @override
  Widget build(BuildContext context) {
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
                  child: textSubtitle("ปรับแต่งคะแนนสะสม"),
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
    const dayTextStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final weekendTextStyle =
        TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.purple[800],
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.5),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected == true
                            ? Colors.white
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
    ) {
      values =
          values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
      var valueText = (values.isNotEmpty ? values[0] : null)
          .toString()
          .replaceAll('00:00:00.000', '');

      if (datePickerType == CalendarDatePicker2Type.multi) {
        valueText = values.isNotEmpty
            ? values
                .map((v) => v.toString().replaceAll('00:00:00.000', ''))
                .join(', ')
            : 'null';
      } else if (datePickerType == CalendarDatePicker2Type.range) {
        if (values.isNotEmpty) {
          final startDate = values[0].toString().replaceAll('00:00:00.000', '');
          final endDate = values.length > 1
              ? values[1].toString().replaceAll('00:00:00.000', '')
              : 'null';
          valueText = '$startDate to $endDate';
        } else {
          return 'null';
        }
      }

      return valueText;
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24, top: 36, right: 24),
            child: TopMenuWidget(),
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
                        imgCover,
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
                  "ชื่อโปรโมชั่น",
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
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, top: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Text(
                  "คำอธิบายโปรโมชั่น",
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
              controller: _controllerSub,
              // initialValue: "Freshing beer อร่อยสดชื่น",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "DBHeaventCond",
                  fontSize: 20),
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, top: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Text(
                  "ชนิดของคะแนน",
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
            padding: EdgeInsets.only(top: 0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white),
              child: DropdownMenu<String>(
                width: (MediaQuery.of(context).size.width) - 48,
                inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    fillColor: Colors.white),
                initialSelection: list.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 24, top: 10),
                // color: Colors.amber,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right:
                              ((MediaQuery.of(context).size.width - 48) / 5)),
                      child: Text(
                        "ราคา(คะแนน)",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "DBHeaventCond",
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 48) / 2.5,
                      child: TextFormField(
                        controller: _controllerPrice,
                        // initialValue: "Freshing beer อร่อยสดชื่น",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "DBHeaventCond",
                            fontSize: 20),
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 24, top: 10),
                // color: Colors.amber,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right:
                              ((MediaQuery.of(context).size.width - 48) / 5)),
                      child: Text(
                        "จำนวนสิทธิ์",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "DBHeaventCond",
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 48) / 2.5,
                      child: TextFormField(
                        controller: _controllerQuote,
                        // initialValue: "Freshing beer อร่อยสดชื่น",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "DBHeaventCond",
                            fontSize: 20),
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, top: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Text(
                  "ระยะเวลาโปรโมชั่น",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "DBHeaventCond",
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          SizedBox(
            // width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.transparent)))),
                    onPressed: () async {
                      final values = await showCalendarDatePicker2Dialog(
                        context: context,
                        config: config,
                        dialogSize: const Size(325, 370),
                        // borderRadius: BorderRadius.circular(16),
                        value: _dialogCalendarPickerValue,
                        dialogBackgroundColor: Colors.white,
                      );
                      if (values != null) {
                        // ignore: avoid_print
                        print(_getValueText(
                          config.calendarType,
                          values,
                        ));

                        setState(() {
                          _dialogCalendarPickerValue = values;
                          dateValue = _getValueText(
                            config.calendarType,
                            values,
                          );
                        });
                      }
                    },
                    child: Container(
                      height: 45,
                      width: (MediaQuery.of(context).size.width) - 96,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(dateValue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            child: Column(
              children: [
                // Padding(
                //   padding: EdgeInsets.only(left: 0, bottom: 2),
                //   child: Text(
                //     textAlign: TextAlign.left,
                //     "Tips: คะแนนสะสมใช้ในการทำการตลาดเพื่อแจกจ่ายให้ลูกค้า",
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                CustomButtton(
                  title: "ยืนยัน",
                  onPresseds: () async {
                    updatePoint();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
