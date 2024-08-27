import 'package:flutter/material.dart';

@immutable
class CampaignsDTO {
  const CampaignsDTO(
      {required this.amount,
      required this.pointId,
      required this.pointImg,
      required this.id,
      required this.campaignId});

  CampaignsDTO.fromJson(Map<String, Object?> json)
      : this(
          id: json['sub']! as String,
          pointId: json['img']! as String,
          pointImg: json['title']! as String,
          amount: json['score']! as int,
          campaignId: json['collectionId']! as String,
        );

  final String id;
  final String pointId;
  final String pointImg;
  final int amount;
  final String campaignId;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'pointId': pointId,
      'pointImg': pointImg,
      'amount': amount,
      'campaignId': campaignId
    };
  }
}
