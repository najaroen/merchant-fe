import 'package:flutter/cupertino.dart';

@immutable
class PromotionDTO {
  const PromotionDTO(
      {required this.price,
      required this.period,
      required this.img,
      required this.id,
      required this.sub,
      required this.title,
      required this.uid,
      required this.campaignId});

  PromotionDTO.fromJson(Map<String, Object?> json)
      : this(
          price: json['img']! as String,
          img: json['img']! as String,
          id: json['id']! as String,
          sub: json['sub']! as String,
          title: json['title']! as String,
          uid: json['uid']! as String,
          period: json['period']! as String,
          campaignId: json['campaignId']! as String,
        );

  final String price;
  final String id;
  final String sub;
  final String title;
  final String uid;
  final String campaignId;
  final String period;
  final String img;
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'price': price,
      'sub': sub,
      'title': title,
      'uid': uid,
      'period': period,
      'img': img,
      'campaignId': campaignId
    };
  }
}
