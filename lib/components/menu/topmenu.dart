import 'package:flutter/material.dart';
import 'package:merchant/helper/text/text-custom.dart';

Widget topMenuComponent(
    BuildContext context, String title, void Function()? onPress) {
  return Row(
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
              padding: const EdgeInsets.all(0),
              child: textSubtitle(title),
            )
          ],
        ),
      ),
      IconButton(
        onPressed: onPress,
        icon: const Icon(Icons.history_outlined),
        color: Colors.white,
      )
    ],
  );
}
