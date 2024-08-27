import 'package:flutter/material.dart';
import 'package:merchant/common/default-button.dart';
import 'package:merchant/helper/text/text-custom.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ShowQR extends StatefulWidget {
  const ShowQR(
      {super.key,
      required this.title,
      required this.pointId,
      required this.amount});
  final String title;
  final String pointId;
  final String amount;
  @override
  State<StatefulWidget> createState() {
    return ShowQRState(title: title, amount: amount, pointId: pointId);
  }
}

class ShowQRState extends State<ShowQR> {
  ShowQRState(
      {required this.title, required this.pointId, required this.amount});
  final String title;
  final String pointId;
  final String amount;
  @protected
  late QrCode qrCode;

  @protected
  late QrImage qrImage;

  @protected
  late PrettyQrDecoration decoration;

  @override
  void initState() {
    super.initState();

    qrCode = QrCode.fromData(
      data: "${pointId}|${amount}",
      errorCorrectLevel: QrErrorCorrectLevel.H,
    );

    qrImage = QrImage(qrCode);

    decoration = const PrettyQrDecoration(
      shape: PrettyQrSmoothSymbol(
        color: Color(0xFF0f1630),
      ),
      // image: _PrettyQrSettings.kDefaultQrDecorationImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0f1630),
      body: Container(
        padding: const EdgeInsets.only(top: 36, left: 24, right: 24),
        child: Column(
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
                      const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: textSubtitle(title),
                      )
                    ],
                  ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.history_outlined),
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * (0.5 / 4)),
              child: Column(
                children: [
                  const Text(
                    "สแกน QR Code นี้",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "DBHeaventCond",
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "รับคะแนนสะสม ${amount} คะแนน",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "DBHeaventCond",
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              width: 220,
              height: 220,
              margin: EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white),
              child: Column(
                children: [
                  _PrettyQrAnimatedView(
                    qrImage: qrImage,
                    decoration: decoration,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * (1.22 / 4)),
              child: CustomButtton(
                title: "ยืนยัน",
                onPresseds: () async {
                  // TODO: put logic here
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PrettyQrAnimatedView extends StatefulWidget {
  @protected
  final QrImage qrImage;

  @protected
  final PrettyQrDecoration decoration;

  const _PrettyQrAnimatedView({
    required this.qrImage,
    required this.decoration,
  });

  @override
  State<_PrettyQrAnimatedView> createState() => _PrettyQrAnimatedViewState();
}

class _PrettyQrAnimatedViewState extends State<_PrettyQrAnimatedView> {
  @protected
  late PrettyQrDecoration previosDecoration;

  @override
  void initState() {
    super.initState();

    previosDecoration = widget.decoration;
  }

  @override
  void didUpdateWidget(
    covariant _PrettyQrAnimatedView oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (widget.decoration != oldWidget.decoration) {
      previosDecoration = oldWidget.decoration;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TweenAnimationBuilder<PrettyQrDecoration>(
        tween: PrettyQrDecorationTween(
          begin: previosDecoration,
          end: widget.decoration,
        ),
        curve: Curves.ease,
        duration: const Duration(
          milliseconds: 240,
        ),
        builder: (context, decoration, child) {
          return PrettyQrView(
            qrImage: widget.qrImage,
            decoration: decoration,
          );
        },
      ),
    );
  }
}
