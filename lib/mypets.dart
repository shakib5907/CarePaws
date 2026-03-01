import 'package:flutter/material.dart';

const appGreen = Color(0xFF0da86c);


class Pet {
  final String name;
  final String description;

  Pet({required this.name, required this.description});
}

class MyPetsPage extends StatefulWidget {
  const MyPetsPage({super.key});

  @override
  State<MyPetsPage> createState() => _MyPetsPageState();
}

class _MyPetsPageState extends State<MyPetsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<Pet> _pets = [
    Pet(name: 'Bruno', description: 'Friendly dog (dummy pet)'),
  ];

  bool _showForm = false;

  void _startAdd() {
    setState(() => _showForm = true);
  }

  void _cancelAdd() {
    _nameController.clear();
    _descriptionController.clear();
    FocusScope.of(context).unfocus();
    setState(() => _showForm = false);
  }

  void _savePet() {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();

    if (name.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter name and description')),
      );
      return;
    }

    setState(() {
      _pets.add(Pet(name: name, description: description));
      _showForm = false;
    });

    _nameController.clear();
    _descriptionController.clear();
    FocusScope.of(context).unfocus();
  }

  void _deletePet(int index) {
    setState(() => _pets.removeAt(index));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
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
      body: Column(
        children: [
          // Show form only after clicking Add Pet
          if (_showForm)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Pet Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _cancelAdd,
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _savePet,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appGreen,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          Expanded(
            child: _pets.isEmpty
                ? const Center(
              child: Text(
                'No pets yet.\nTap + to add one.',
                textAlign: TextAlign.center,
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
              itemCount: _pets.length,
              itemBuilder: (context, index) {
                final pet = _pets[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: const Icon(Icons.pets, color: appGreen),
                    ),
                    title: Text(
                      pet.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      pet.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: appGreen),
                      onPressed: () => _deletePet(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startAdd,
        backgroundColor: appGreen,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}