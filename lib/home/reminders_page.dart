import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reminder_data.dart';
import 'add_reminder_page.dart';

const appGreen = Color(0xFF0da86c);

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  final DateTime _today = DateTime.now();
  late int _selectedDay;
  List<ReminderItem> _reminders = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _today.day;
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> saved = prefs.getStringList('reminders') ?? [];
    setState(() {
      _reminders = saved.map((s) => ReminderItem.fromJsonString(s)).toList();
    });
  }

  Future<void> _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'reminders',
      _reminders.map((r) => r.toJsonString()).toList(),
    );
  }

  Future<void> _goToAddPage() async {
    final ReminderItem? newReminder = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddReminderPage()),
    );
    if (newReminder != null) {
      setState(() => _reminders.add(newReminder));
      await _saveReminders();
    }
  }

  Future<void> _deleteReminder(int originalIndex) async {
    setState(() => _reminders.removeAt(originalIndex));
    await _saveReminders();
  }

  Future<void> _toggleReminder(int originalIndex) async {
    setState(() {
      _reminders[originalIndex] = _reminders[originalIndex].toggleActive();
    });
    await _saveReminders();
  }

  // Returns only reminders whose date matches the selected day
  List<MapEntry<int, ReminderItem>> _filteredReminders() {
    return _reminders
        .asMap()
        .entries
        .where((e) => e.value.date.day == _selectedDay)
        .toList();
  }

  List<DateTime> _getWeekDays() {
    final List<DateTime> days = [];
    for (int i = -1; i <= 5; i++) {
      days.add(_today.add(Duration(days: i)));
    }
    return days;
  }

  String _dayLabel(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  String _monthYear(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _getWeekDays();
    final filtered = _filteredReminders();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      body: Column(
        children: [

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            decoration: const BoxDecoration(
              color: appGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Today',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _monthYear(_today),
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: weekDays.map((date) {
                      final isSelected = date.day == _selectedDay;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDay = date.day),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _dayLabel(date),
                                style: TextStyle(
                                  color: isSelected ? appGreen : Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${date.day}',
                                style: TextStyle(
                                  color: isSelected ? appGreen : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: List.generate(3, (i) => Container(
                                  margin: const EdgeInsets.only(right: 2),
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: isSelected ? appGreen : Colors.white38,
                                    shape: BoxShape.circle,
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'To Take',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: _goToAddPage,
                        child: const Text(
                          '+ Add',
                          style: TextStyle(
                            color: appGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Expanded(
                    child: filtered.isEmpty
                        ? const Center(
                      child: Text(
                        'No reminders for this day.\nTap + Add to create one.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black38, fontSize: 14),
                      ),
                    )
                        : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        final originalIndex = filtered[i].key;
                        final reminder = filtered[i].value;
                        return _buildReminderRow(reminder, originalIndex);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildReminderRow(ReminderItem reminder, int originalIndex) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 45,
            child: Text(
              reminder.timeLabel,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: _buildReminderCard(reminder, originalIndex)),
        ],
      ),
    );
  }

  Widget _buildReminderCard(ReminderItem reminder, int originalIndex) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: reminder.color, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    reminder.subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        reminder.timeRange,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => _toggleReminder(originalIndex),
              icon: Icon(
                reminder.isActive
                    ? Icons.notifications_active_rounded
                    : Icons.notifications_off_rounded,
                color: reminder.isActive ? appGreen : Colors.grey,
                size: 22,
              ),
            ),
            IconButton(
              onPressed: () => _deleteReminder(originalIndex),
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}