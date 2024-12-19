import 'package:bank_sampah/helper/database_helper.dart';
import 'package:bank_sampah/models/waste_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddWasteScreen extends StatefulWidget {
  @override
  _AddWasteScreenState createState() => _AddWasteScreenState();
}

class _AddWasteScreenState extends State<AddWasteScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _selectedType = 'Organik';
  DateTime _selectedDate = DateTime.now();

  List<String> wasteTypes = ['Organik', 'Anorganik', 'B3', 'Lainnya'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveWaste() async {
    if (_formKey.currentState!.validate()) {
      final waste = Waste(
        name: _nameController.text,
        type: _selectedType,
        weight: int.parse(_weightController.text),
        date: DateFormat('yyyy-MM-dd').format(_selectedDate),
      );

      await _dbHelper.insertWaste(waste);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data sampah berhasil disimpan')),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Sampah'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Sampah',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon isi nama sampah';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Jenis Sampah',
                  border: OutlineInputBorder(),
                ),
                items: wasteTypes.map((String type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Berat (kg)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon isi berat sampah';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Mohon masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Tanggal'),
                subtitle: Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveWaste,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Simpan Data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
