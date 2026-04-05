import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const appGreen = Color(0xFF0da86c);
const _kPetsKey = 'my_pets';

class MyPetsPage extends StatefulWidget {
  const MyPetsPage({super.key});

  @override
  State<MyPetsPage> createState() => _MyPetsPageState();
}

class _MyPetsPageState extends State<MyPetsPage> {
  final _name = TextEditingController();
  final _desc = TextEditingController();
  List<Map<String, String>> _pets = [];

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kPetsKey);
    if (raw != null) {
      final decoded = List<Map<String, dynamic>>.from(jsonDecode(raw));
      setState(() {
        _pets = decoded.map((e) => e.cast<String, String>()).toList();
      });
    }
  }

  Future<void> _savePets() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPetsKey, jsonEncode(_pets));
  }

  void _addPet() {
    final name = _name.text.trim();
    final desc = _desc.text.trim();
    if (name.isEmpty || desc.isEmpty) return;

    setState(() => _pets.add({'name': name, 'desc': desc}));
    _savePets(); // 👈 save after adding
    _name.clear();
    _desc.clear();
    FocusScope.of(context).unfocus();
  }

  void _deletePet(int i) {
    setState(() => _pets.removeAt(i));
    _savePets();
  }

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text('My Pets'),
        backgroundColor: appGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Pet Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _desc,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _addPet,
                icon: const Icon(Icons.add),
                label: const Text('Add Pet', style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Card(
                color: Colors.white,
                child: _pets.isEmpty
                    ? const Center(child: Text('No pets yet'))
                    : ListView.separated(
                  itemCount: _pets.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) => ListTile(
                    leading: const Icon(Icons.pets_outlined, color: appGreen),
                    title: Text(_pets[i]['name']!),
                    subtitle: Text(_pets[i]['desc']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: appGreen),
                      onPressed: () => _deletePet(i),
                    ),
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