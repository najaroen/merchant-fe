import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class EmptyMerchant extends StatelessWidget {
  const EmptyMerchant({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image(
                    width: 120,
                    height: 120,
                    image: Svg('/image/icon-merchant.svg')),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child:
                    Image(width: 60, height: 60, image: Svg('/image/add.svg')),
              )
            ],
          )),
    );
  }
}
