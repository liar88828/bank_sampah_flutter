import 'package:bank_sampah/helper/database_helper.dart';
import 'package:bank_sampah/models/waste_model.dart';
import 'package:bank_sampah/screen/sampah/tambah_sampah_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WasteListScreen extends StatefulWidget {
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
    final wastes = await _dbHelper.getAllWastes();
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

  String _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'organik':
        return '🟢';
      case 'anorganik':
        return '🔵';
      case 'b3':
        return '🔴';
      default:
        return '⚪';
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
                      child: Text(_getTypeColor(waste.type)),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(waste.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jenis: ${waste.type}'),
                        Text('Berat: ${waste.weight} kg'),
                        Text('Tanggal: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(waste.date))}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Konfirmasi'),
                              content: Text('Apakah Anda yakin ingin menghapus data ini?'),
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
            MaterialPageRoute(builder: (context) => AddWasteScreen()),
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
