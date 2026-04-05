import 'dart:convert';
import 'package:flutter/material.dart';

class ReminderItem {
  final String title;
  final String subtitle;
  final String timeRange;
  final String timeLabel;
  final IconData icon;
  final Color color;
  final Color lightColor;
  final bool isActive;
  final DateTime date;

  const ReminderItem({
    required this.title,
    required this.subtitle,
    required this.timeRange,
    required this.timeLabel,
    required this.icon,
    required this.color,
    required this.lightColor,
    required this.date,
    this.isActive = true,
  });

  ReminderItem toggleActive() {
    return ReminderItem(
      title: title,
      subtitle: subtitle,
      timeRange: timeRange,
      timeLabel: timeLabel,
      icon: icon,
      color: color,
      lightColor: lightColor,
      isActive: !isActive,
      date: date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'timeRange': timeRange,
      'timeLabel': timeLabel,
      'iconCode': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
      'isActive': isActive,
      'date': date.toIso8601String(),
    };
  }

  factory ReminderItem.fromJson(Map<String, dynamic> json) {
    return ReminderItem(
      title: json['title'],
      subtitle: json['subtitle'],
      timeRange: json['timeRange'],
      timeLabel: json['timeLabel'],
      icon: IconData(json['iconCode'], fontFamily: json['iconFontFamily']),
      color: const Color(0xFF0da86c),
      lightColor: const Color(0xFFe8f8f1),
      isActive: json['isActive'] ?? true,
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(),
    );
  }

  String toJsonString() => jsonEncode(toJson());

  static ReminderItem fromJsonString(String jsonString) =>
      ReminderItem.fromJson(jsonDecode(jsonString));
}