import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostModel {
  final String text;
  final String creatorUid;
  final int iconCode;
  final Timestamp timestamp;

  PostModel({
    required this.creatorUid,
    required this.text,
    required this.iconCode,
    required this.timestamp,
  });



  // 아이콘 위젯을 반환하는 메서드
  Widget getIconWidget() {
    IconData iconData = _getIconData(iconCode);
    Color iconColor = _getIconColor(iconCode);

    return Icon(
      iconData,
      color: iconColor,
      size: 24,
    );
  }

  // 아이콘 데이터를 반환하는 메서드
  IconData _getIconData(int code) {
    switch (code) {
      case 62302:
        return Icons.sentiment_satisfied_outlined;
      case 62299:
        return Icons.sentiment_dissatisfied_outlined;
      case 62303:
        return Icons.sentiment_very_dissatisfied_outlined;
      case 62304:
        return Icons.sentiment_very_satisfied_outlined;
      case 62300:
        return Icons.sentiment_neutral_outlined;
      default:
        return Icons.sentiment_neutral_outlined; // 기본값 설정
    }
  }

  // 아이콘 색상을 반환하는 메서드
  Color _getIconColor(int code) {
    switch (code) {
      case 62302:
        return Colors.green;
      case 62299:
        return Colors.red;
      case 62303:
        return Colors.amber;
      case 62304:
        return Colors.blue;
      case 62300:
        return Colors.pink;
      default:
        return Colors.grey; // 기본값 설정
    }
  }
  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "creatorUid": creatorUid,
      "iconCode": iconCode,
      "timestamp": timestamp,
    };
  }

  PostModel.fromJson(Map<String, dynamic> json)
      : text = json["text"],
        creatorUid = json["creatorUid"],
        iconCode = json["iconCode"],
        timestamp = json["timestamp"];
}
