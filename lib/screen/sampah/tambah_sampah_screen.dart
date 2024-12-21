import 'package:bank_sampah/helper/database_helper.dart';
import 'package:bank_sampah/models/waste_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TambahSampahScreen extends StatefulWidget {
  final int? id;

  const TambahSampahScreen(this.id, {super.key});

  @override
  _TambahSampahScreenState createState() => _TambahSampahScreenState();
}

class _TambahSampahScreenState extends State<TambahSampahScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _selectedType = 'Organik';
  DateTime _selectedDate = DateTime.now();

  List<String> wasteTypes = [
    'Plastik',
    'Kertas',
    'Logam',
    'Elektronik',
    'Kaca',
    'Organik',
  ];

  @override
  void initState() {
    super.initState();

    // If there's an existing id (for update), load the data
    if (widget.id != null) {
      _loadWasteData(widget.id!);
    }
  }

  // Method to load existing data into the form for updating
  Future<void> _loadWasteData(int id) async {
    final waste = await _dbHelper.getWasteById(id);
    if (waste != null) {
      setState(() {
        _nameController.text = waste.name;
        _weightController.text = waste.weight.toString();
        _selectedType = waste.type;
        _selectedDate = DateTime.parse(waste.date);
      });
    }
  }

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
        id: widget.id,
        // Pass the existing ID for update
        name: _nameController.text,
        type: _selectedType,
        weight: int.parse(_weightController.text),
        date: DateFormat('yyyy-MM-dd').format(_selectedDate),
      );

      if (widget.id == null) {
        // Insert new waste if no id is provided
        await _dbHelper.insertWaste(waste);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data sampah berhasil disimpan')),
        );
      } else {
        // Update existing waste if an id is provided
        await _dbHelper.updateWaste(waste);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data sampah berhasil diperbarui')),
        );
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context);

    return Scaffold(


      // appBar: AppBar(
      //   title: const Text('Tambah Data Sampah'),
      //   backgroundColor: Colors.green,
      // ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              myTheme.colorScheme.primaryContainer,
              Color(0xE5E0FDE9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: SvgPicture.asset(
                          'lib/images/undraw_fill-forms_npwp.svg',
                          semanticsLabel: 'Form Illustration',
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Tambah Data Sampah',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Sampah',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.edit, color: Colors.green),
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
                          prefixIcon: Icon(Icons.category, color: Colors.green),
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
                          prefixIcon: Icon(Icons.scale, color: Colors.green),
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
                        subtitle: Text(
                          DateFormat('dd/MM/yyyy').format(_selectedDate),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.calendar_today,
                            color: Colors.green),
                        onTap: () => _selectDate(context),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _saveWaste,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text('Simpan Data',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
