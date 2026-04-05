import 'package:flutter/material.dart';

const appGreen = Color(0xFF0da86c);

class EmergencyHelpPage extends StatefulWidget {
  const EmergencyHelpPage({super.key});

  @override
  State<EmergencyHelpPage> createState() => _EmergencyHelpPageState();
}

class _EmergencyHelpPageState extends State<EmergencyHelpPage> {
  final _searchController = TextEditingController();

  final List<Map<String, dynamic>> _alternatives = [
    {
      'name': 'Napa',
      'alt': 'Ginger + Turmeric',
      'desc': 'Natural anti-inflammatory properties to reduce swelling and pain.',
    },
    {
      'name': 'Pain Relief',
      'alt': 'Peppermint Oil',
      'desc': 'Calms muscle spasms and reduces inflammation with cooling effects.',
    },
    {
      'name': 'Anti-Inflammatory',
      'alt': 'Curcumin',
      'desc': 'Derived from turmeric, it helps reduce inflammation and pain naturally.',
    },
    {
      'name': 'Fever',
      'alt': 'Peppermint Tea',
      'desc': 'Helps reduce fever with its cooling and decongestant properties.',
    },
  ];

  void _openVetContact() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text(
                  'Contact Vet',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.call_outlined),
                title: const Text('Emergency Call'),
                subtitle: const Text('+88001819845424'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.chat_outlined),
                title: const Text('Chat with Vet'),
                subtitle: const Text('Demo action'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase();

    final filtered = _alternatives.where((alt) {
      final nameMatch = alt['name'].toLowerCase().contains(query);
      final altMatch = alt['alt'].toLowerCase().contains(query);
      return nameMatch || altMatch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text('Emergency Help'),
        backgroundColor: appGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}), // 1) live search
              decoration: InputDecoration(
                labelText: 'Search medicine (e.g., Napa)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {}); // 2) clear search
                  },
                ),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: appGreen, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                color: Colors.white,
                child: filtered.isEmpty
                    ? const Center(
                  child: Text(
                    'No medicine found',
                    style: TextStyle(fontSize: 16),
                  ),
                )
                    : ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final alt = filtered[i];
                    return ListTile(
                      leading: const Icon(Icons.pets_outlined, color: appGreen),
                      title: Text(alt['name']),
                      subtitle: Text(
                        '${alt['alt']} - ${alt['desc']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Consult a licensed vet if needed.',
              style: TextStyle(fontSize: 12, color: Colors.redAccent),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openVetContact,
        icon: const Icon(Icons.medical_services_outlined),
        label: const Text('Contact Vet'),
        backgroundColor: appGreen,
        foregroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }
}