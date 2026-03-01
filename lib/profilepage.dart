import 'package:flutter/material.dart';

const appGreen = Color(0xFF0da86c);

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: appGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const CircleAvatar(
              radius: 42,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 46, color: appGreen),
            ),
            const SizedBox(height: 12),
            const Text(
              'Joey Tribbiani',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'joeysandwich@gmail.com',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            Card(
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.phone_outlined),
                    title: Text('Phone'),
                    subtitle: Text('+91 98765 43210'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text('Address'),
                    subtitle: Text('97/3,Manik Nagar, Dhaka-1203'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}