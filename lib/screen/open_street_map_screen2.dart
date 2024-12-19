import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapScreen2 extends StatefulWidget {
  const OpenStreetMapScreen2({super.key});

  @override
  State<OpenStreetMapScreen2> createState() => _OpenStreetMapScreen2State();
}

class _OpenStreetMapScreen2State extends State<OpenStreetMapScreen2> {
  @override
  Widget build(BuildContext context) {
    final List<Marker> _markers = [
      Marker(
        point: const LatLng(-7.064675907749497, 110.38302813066154),
        width: 200,
        height: 300,
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Image.asset('lib/images/rumah_febrian.jpg'),
            const Text(
              'Rumah Febrian',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            GestureDetector(
              onTap: () {
                showInfoDialog(
                  context,
                  title: 'Bank Sampah Febrian',
                  description: 'Bank Sampah Febrian berlokasi di pusat kota. Tempat ini melayani pengelolaan sampah dengan sistem ramah lingkungan.',
                  imagePath: 'lib/images/rumah_febrian.jpg',
                );
              },
              child: const Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      Marker(
        point: const LatLng(-7.009648691607778, 110.39317085582776),
        width: 200,
        height: 300,
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Image.asset('lib/images/rumah_bayu.jpg'),
            const Text(
              'Rumah Bayu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            GestureDetector(
              onTap: () {
                showInfoDialog(
                  context,
                  title: 'Bank Sampah Bayu',
                  description: 'Bank Sampah Bayu terletak di kawasan hijau. Mendukung komunitas untuk mengelola sampah organik dan non-organik.',
                  imagePath: 'lib/images/rumah_bayu.jpg',
                );
              },
              child: const Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    ];

    void addLocationMarker(tapPosition, point) {
      // This will be triggered when a tap occurs
      setState(() {
        _markers.add(
          Marker(
            point: point,
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,
            child: const Icon(
              Icons.location_pin,
              size: 60,
              color: Colors.green, // Green color for the new marker
            ),
          ),
        );
      });
      // Print the latitude and longitude
      print('Tapped at Latitude: ${point.latitude}, Longitude: ${point.longitude}');
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Peta Bank Sampah Ceria Sejahtera'),
          leading: BackButton(),
          actions: [],
        ),
        body: FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(-7.009559221378535, 110.39355257849022),
            initialZoom: 13,
            onTap: (tapPosition, point) {},
            interactionOptions: const InteractionOptions(
              flags: ~InteractiveFlag.doubleTapZoom,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(markers: _markers),
          ],
        ));
  }

  void showInfoDialog(BuildContext context, {required String title, required String description, required String imagePath}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text(description, textAlign: TextAlign.justify),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
