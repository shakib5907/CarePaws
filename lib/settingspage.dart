import 'package:flutter/material.dart';

const appGreen = Color(0xFF0da86c);

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsOn = true;
  void showAppSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: appGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),

          SwitchListTile(
            value: notificationsOn,
            onChanged: (v) => setState(() => notificationsOn = v),
            activeColor: appGreen,
            secondary: const Icon(Icons.notifications_none, color: appGreen),
            title: const Text('Notifications'),
          ),

          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.help_outline, color: appGreen),
            title: const Text('FAQ'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showAppSnackBar(context, 'NO FAQ TILL NOW');
            },
          ),

          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.info_outline, color: appGreen),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showAppSnackBar(context, 'VERY BIG APP');

            },
          ),
        ],
      ),
    );
  }
}