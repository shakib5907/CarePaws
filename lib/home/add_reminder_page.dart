import 'package:flutter/material.dart';
import 'reminder_data.dart';

const appGreen = Color(0xFF0da86c);

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  int _selectedType = 1;
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _nameFocus = FocusNode();
  final _amountFocus = FocusNode();
  TimeOfDay? _selectedTime;

  final List<Map<String, dynamic>> _types = [
    {'label': 'Vaccine', 'icon': Icons.vaccines_rounded},
    {'label': 'Medicine', 'icon': Icons.medication_rounded},
    {'label': 'Liquid', 'icon': Icons.water_drop_rounded},
  ];

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: appGreen,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour : $minute $period';
  }

  String _formatTimeLabel(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour $period';
  }

  String _formatTimeRange(TimeOfDay time) {
    final startHour = time.hour.toString().padLeft(2, '0');
    final startMinute = time.minute.toString().padLeft(2, '0');
    final endTime = TimeOfDay(hour: (time.hour + 1) % 24, minute: time.minute);
    final endHour = endTime.hour.toString().padLeft(2, '0');
    final endMinute = endTime.minute.toString().padLeft(2, '0');
    return '$startHour:$startMinute - $endHour:$endMinute';
  }

  void _save() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a reminder name')),
      );
      return;
    }
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time')),
      );
      return;
    }

    final newReminder = ReminderItem(
      title: _nameController.text.trim(),
      subtitle: _amountController.text.trim().isEmpty
          ? _types[_selectedType]['label']
          : _amountController.text.trim(),
      timeRange: _formatTimeRange(_selectedTime!),
      timeLabel: _formatTimeLabel(_selectedTime!),
      icon: _types[_selectedType]['icon'],
      color: appGreen,
      lightColor: const Color(0xFFe8f8f1),
      date: DateTime.now(),
    );

    Navigator.pop(context, newReminder);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _nameFocus.dispose();
    _amountFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Add Reminder',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Add ',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(
                          text: 'daily',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: appGreen,
                            decoration: TextDecoration.underline,
                            decorationColor: appGreen,
                          ),
                        ),
                        TextSpan(
                          text: ' reminder',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'And set your schedule',
                    style: TextStyle(color: Colors.black38, fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Reminder Type ──────────────────────────────────────
                  const Text(
                    'REMINDER TYPE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black38,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: List.generate(_types.length, (index) {
                      final isSelected = _selectedType == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedType = index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFe8f8f1) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? appGreen : Colors.black12,
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                _types[index]['icon'],
                                color: isSelected ? appGreen : Colors.black38,
                                size: 26,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _types[index]['label'],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isSelected ? appGreen : Colors.black38,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 24),
                  const Divider(color: Colors.black12),
                  const SizedBox(height: 16),

                  // ── Reminder Name ──────────────────────────────────────
                  const Text(
                    'REMINDER NAME',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black38,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          focusNode: _nameFocus,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => FocusScope.of(context).requestFocus(_nameFocus),
                        child: const Text(
                          '+ Add',
                          style: TextStyle(
                            color: appGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Divider(color: Colors.black12),
                  const SizedBox(height: 16),

                  // ── Amount ─────────────────────────────────────────────
                  const Text(
                    'AMOUNT',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black38,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          focusNode: _amountFocus,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => FocusScope.of(context).requestFocus(_amountFocus),
                        child: const Text(
                          '+ Add',
                          style: TextStyle(
                            color: appGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Divider(color: Colors.black12),
                  const SizedBox(height: 16),

                  // ── Time ───────────────────────────────────────────────
                  const Text(
                    'TIME',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black38,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickTime,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedTime != null
                              ? _formatTime(_selectedTime!)
                              : '00 : 00 AM',
                          style: TextStyle(
                            fontSize: 14,
                            color: _selectedTime != null ? Colors.black87 : Colors.black26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          '+ Add',
                          style: TextStyle(
                            color: appGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: appGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}