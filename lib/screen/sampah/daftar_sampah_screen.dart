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

  @override
  void initState() {
    super.initState();
    _loadWastes();
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
    });
  }

  Future<void> _deleteWaste(int id) async {
    await _dbHelper.deleteWaste(id);
    _loadWastes();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data sampah berhasil dihapus')),
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
        title: Text('Daftar Sampah'),
      ),
      body: _wastes.isEmpty
          ? Center(
              child: Text('Belum ada data sampah'),
            )
          : ListView.builder(
              itemCount: _wastes.length,
              itemBuilder: (context, index) {
                final waste = _wastes[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Konfirmasi'),
                              content: Text('Pilih Opsi Untuk Mengubah ?'),
                              actions: [
                                TextButton(
                                  child: Text('Batal'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: Text('Hapus'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _deleteWaste(waste.id!);
                                  },
                                ),
                                TextButton(
                                  child: Text('Edit'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahSampahScreen(null)),
          );
          if (result == true) {
            _loadWastes();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
