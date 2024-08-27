import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PointCard extends StatelessWidget {
  PointCard(
      {super.key,
      required this.onSelected,
      required this.title,
      required this.sub,
      required this.cover,
      required this.id,
      required this.selected});
  final String title;
  final String sub;
  final String cover;
  final String id;
  final String selected;
  final void Function() onSelected;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onSelected,
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            border: Border.all(
                color:
                    id == selected ? Colors.blue.shade600 : Colors.transparent,
                width: id == selected ? 3 : 0)
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.shade300,
            //     spreadRadius: 0.4,
            //     blurRadius: 3,
            //     offset: const Offset(0, 0.2),
            //   ).scale(4)
            // ]
            ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: SizedBox.fromSize(
                // size: Size.fromRadius(48), // Image radius
                child: Image.network(this.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2, left: 2),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  this.title,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  this.sub,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 8,
                      color: Color(0xffA6A6A6),
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
