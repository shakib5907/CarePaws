import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reminder_data.dart';
import 'reminders_page.dart';

class UpcomingSection extends StatelessWidget {
  const UpcomingSection({super.key});

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
                Text(
                  'Activity Reminder',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const RemindersPage()));
                  },
                  child: Text(
                    'See all »',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0da86c),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          SizedBox(
            height: 130,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: demoReminders.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final reminder = demoReminders[index];
                return _buildReminderCard(reminder);
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
                  style: GoogleFonts.poppins(
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
            style: GoogleFonts.poppins(fontSize: 11, color: Colors.black45),
          ),

          const Spacer(),
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 13, color: reminder.color),
              const SizedBox(width: 4),
              Text(
                reminder.timeRange,
                style: GoogleFonts.poppins(fontSize: 11, color: Colors.black45),
              ),
              const Spacer(),
              Icon(Icons.notifications_none_rounded, size: 18, color: reminder.color),
            ],
          ),

        ],
      ),
    );
  }
}