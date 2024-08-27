import 'package:flutter/material.dart';

class CampaignListView extends StatefulWidget {
  @override
  State<CampaignListView> createState() => _CampaignListView();
}

class _CampaignListView extends State<CampaignListView> {
  final ScrollController _listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget MyContainer = Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      height: MediaQuery.of(context).size.height * 1 / 4,
      width: MediaQuery.of(context).size.width * 1 * (90 / 100),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
    );
    // TODO: implement build
    // return Container(color: Colors.amber,);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: [
          SizedBox(
            width: constraints.maxWidth * 1 * (90 / 100),
            // child: Scrollbar(
            //   thumbVisibility: true,
            //   controller: _listController,
            //   child: ListView.builder(
            //       itemCount: 5,
            //       controller: _listController,
            //       itemBuilder: (BuildContext context, int index) {
            //         return MyContainer;
            //       }),
            // ),
          )
        ],
      );
    });
  }
}
// 2845000000