import 'package:flutter/material.dart';

const appGreen = Color(0xFF0da86c);

class FindVetPage extends StatelessWidget {
  const FindVetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> vetNames = const [
      'Care Animal Clinic',
      'PetCare Vet Center',
      'Green Paws Hospital',
      'Happy Tails Vet',
      'PetLife Clinic',
      '*Sir Ja Valo Mone Kore*'
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text('Find Vet'),
        backgroundColor: appGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: vetNames.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, index) {
          return Card(
            color: Colors.white,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0x1F0da86c),
                child: Icon(Icons.local_hospital_outlined, color: appGreen),
              ),
              title: Text(
                vetNames[index],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Nearby vet'),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}