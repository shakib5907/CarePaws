import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reminder_data.dart';
import 'reminders_page.dart';

class UpcomingSection extends StatefulWidget {
  const UpcomingSection({super.key});

  @override
  State<UpcomingSection> createState() => _UpcomingSectionState();
}

class _UpcomingSectionState extends State<UpcomingSection> {
  List<ReminderItem> _reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> saved = prefs.getStringList('reminders') ?? [];
    if (mounted) {
      setState(() {
        _reminders = saved.map((s) => ReminderItem.fromJsonString(s)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Activity Reminder',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RemindersPage()),
                    );
                    _loadReminders();
                  },
                  child: const Text(
                    'See all »',
                    style: TextStyle(
                      color: Color(0xFF0da86c),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          _reminders.isEmpty
              ? const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Text(
              'No reminders yet. Tap See all to add one.',
              style: TextStyle(fontSize: 12, color: Colors.black38),
            ),
          )
              : SizedBox(
            height: 130,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _reminders.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return _buildReminderCard(_reminders[index]);
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildReminderCard(ReminderItem reminder) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: reminder.color.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: reminder.lightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(reminder.icon, color: reminder.color, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  reminder.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            reminder.subtitle,
            style: const TextStyle(fontSize: 11, color: Colors.black45),
          ),

          const Spacer(),
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 13, color: reminder.color),
              const SizedBox(width: 4),
              Text(
                reminder.timeRange,
                style: const TextStyle(fontSize: 11, color: Colors.black45),
              ),
              const Spacer(),
              Icon(
                reminder.isActive
                    ? Icons.notifications_active_rounded
                    : Icons.notifications_off_rounded,
                color: reminder.isActive ? reminder.color : Colors.grey,
                size: 18,
              ),
            ],
          ),

        ],
      ),
    );
  }
}