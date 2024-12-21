import 'package:bank_sampah/helper/database_helper.dart';
import 'package:bank_sampah/models/waste_model.dart';
import 'package:bank_sampah/screen/sampah/tambah_sampah_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WasteListScreen extends StatefulWidget {
  final String? typeWaste;

  WasteListScreen(this.typeWaste);

  @override
  _WasteListScreenState createState() => _WasteListScreenState();
}

class _WasteListScreenState extends State<WasteListScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Waste> _wastes = [];
  List<Waste> _filteredWastes = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWastes();
    _searchController.addListener(_filterWastes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadWastes() async {
    List<Waste> wastes = [];
    if (widget.typeWaste == null) {
      wastes = await _dbHelper.getAllWastes();
    } else {
      wastes = await _dbHelper.getAllWastesByType(widget.typeWaste!);
    }

    setState(() {
      _wastes = wastes;
      _filteredWastes = wastes; // Inisialisasi daftar yang difilter
    });
  }

  void _filterWastes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredWastes = _wastes.where((waste) {
        final nameLower = waste.name.toLowerCase();
        final typeLower = waste.type.toLowerCase();
        return nameLower.contains(query) || typeLower.contains(query);
      }).toList();
    });
  }

  Future<void> _deleteWaste(int id) async {
    await _dbHelper.deleteWaste(id);
    _loadWastes();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data sampah berhasil dihapus')),
    );
  }

  IconData _getTypeColor(String type) {
    switch (type) {
      case 'Plastik':
        return Icons.delete_outline;
      case 'Kertas':
        return Icons.description_outlined;
      case 'Logam':
        return Icons.pedal_bike_rounded;
      case 'Elektronik':
        return Icons.devices;
      case 'Kaca':
        return Icons.screenshot_monitor;
      case 'Organik':
        return Icons.energy_savings_leaf_sharp;
      default:
        return Icons.abc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Sampah'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari sampah...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredWastes.isEmpty
                ? const Center(
              child: Text('Belum ada data sampah'),
            )
                : ListView.builder(
              itemCount: _filteredWastes.length,
              itemBuilder: (context, index) {
                final waste = _filteredWastes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(_getTypeColor(waste.type)),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(waste.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jenis: ${waste.type}'),
                        Text('Berat: ${waste.weight} kg'),
                        Text(
                            'Tanggal: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(waste.date))}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Konfirmasi'),
                              content: const Text('Pilih Opsi Untuk Mengubah ?'),
                              actions: [
                                TextButton(
                                  child: const Text('Batal'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: const Text('Hapus'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _deleteWaste(waste.id!);
                                  },
                                ),
                                TextButton(
                                  child: const Text('Edit'),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TambahSampahScreen(waste.id)));
                                    if (result == true) {
                                      _loadWastes();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahSampahScreen(null)),
          );
          if (result == true) {
            _loadWastes();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
