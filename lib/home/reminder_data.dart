import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderItem {
  final String title;
  final String subtitle;
  final String timeRange;
  final String timeLabel;
  final IconData icon;
  final Color color;
  final Color lightColor;

  const ReminderItem({
    required this.title,
    required this.subtitle,
    required this.timeRange,
    required this.timeLabel,
    required this.icon,
    required this.color,
    required this.lightColor,
  });
}
const List<ReminderItem> demoReminders = [
  ReminderItem(
    title: 'NexGard Chewables',
    subtitle: '1 Tablet, per day',
    timeRange: '08:00 - 08:30',
    timeLabel: '8 AM',
    icon: Icons.medication_rounded,
    color: Color(0xFF0da86c),
    lightColor: Color(0xFFe8f8f1),
  ),
  ReminderItem(
    title: 'Rabies Vaccine',
    subtitle: 'Annual vaccination',
    timeRange: '10:00 - 10:30',
    timeLabel: '10 AM',
    icon: Icons.vaccines_rounded,
    color: Color(0xFF1E88E5),
    lightColor: Color(0xFFe8f0ff),
  ),
  ReminderItem(
    title: 'Vitamin Supplement',
    subtitle: '2 capsules, daily',
    timeRange: '13:00 - 13:15',
    timeLabel: '1 PM',
    icon: Icons.local_pharmacy_rounded,
    color: Color(0xFFFF7043),
    lightColor: Color(0xFFfff0ec),
  ),
];