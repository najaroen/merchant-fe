import 'package:flutter/material.dart';

class ContainerCustom extends StatelessWidget {
  const ContainerCustom(
      {super.key, required this.decorations, required this.childs});

  final BoxDecoration decorations;
  final Widget childs;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 56,
        width: 348,
        padding: const EdgeInsets.only(top: 16, left: 0, right: 0, bottom: 16),
        decoration: decorations,
        margin: const EdgeInsets.only(bottom: 5),
        child: Center(
          child: childs,
        ));
  }
}
