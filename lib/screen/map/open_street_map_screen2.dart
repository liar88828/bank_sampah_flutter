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
    final List<Marker> markers = [
      Marker(
        point: const LatLng(-7.064675907749497, 110.38302813066154),
        width: 60,
        height: 60,
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () {
            showInfoDialog(
              context,
              title: 'Bank Sampah Febrian',
              description:
                  'Bank Sampah Febrian berlokasi di pusat kota. Tempat ini melayani pengelolaan sampah dengan sistem ramah lingkungan.',
              imagePath: 'lib/images/rumah_febrian.jpg',
            );
          },
          icon: const Icon(
            Icons.location_pin,
            size: 60,
            color: Colors.red,
          ),
        ),
      ),
      Marker(
        point: const LatLng(-7.009648691607778, 110.39317085582776),
        width: 60,
        height: 60,
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () {
            showInfoDialog(
              context,
              title: 'Bank Sampah Bayu',
              description:
                  'Bank Sampah Bayu terletak di kawasan hijau. Mendukung komunitas untuk mengelola sampah organik dan non-organik.',
              imagePath: 'lib/images/rumah_bayu.jpg',
            );
          },
          icon: const Icon(
            Icons.location_pin,
            size: 60,
            color: Colors.blue,
          ),
        ),
      ),
      Marker(
        point: const LatLng(-7.061370120051095, 110.36189281991304),
        width: 60,
        height: 60,
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () {
            showInfoDialog(
              context,
              title: 'Bank Sampah Unwahas',
              description:
              'Bank Sampah Unwahas adalah solusi inovatif dalam mengelola limbah sekaligus mendukung pelestarian lingkungan. Dengan semangat keberlanjutan, kami berperan sebagai jembatan antara masyarakat dan pengelolaan sampah yang bertanggung jawab, menjadikan sampah sebagai sumber daya bernilai. Bersama, kita wujudkan lingkungan yang lebih bersih, hijau, dan sejahtera! 🌱',
              imagePath: 'lib/images/fakutas_teknik.jpg',
            );
          },
          icon: const Icon(
            Icons.location_pin,
            size: 60,
            color: Colors.green,
          ),
        ),
      ),
    ];

    // void addLocationMarker(tapPosition, point) {
    //   // This will be triggered when a tap occurs
    //   setState(() {
    //     markers.add(
    //       Marker(
    //         point: point,
    //         width: 60,
    //         height: 60,
    //         alignment: Alignment.centerLeft,
    //         child: const Icon(
    //           Icons.location_pin,
    //           size: 60,
    //
    //           color: Colors.green, // Green color for the new marker
    //         ),
    //       ),
    //     );
    //   });
    //   // Print the latitude and longitude
    //   print(
    //       'Tapped at Latitude: ${point.latitude}, Longitude: ${point.longitude}');
    // }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Peta Bank Sampah Ceria Sejahtera'),
          leading: const BackButton(),
          actions: [],
        ),
        body: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(-7.009559221378535, 110.39355257849022),
            initialZoom: 13,
            // onTap: addLocationMarker,
            interactionOptions: InteractionOptions(
              flags: ~InteractiveFlag.doubleTapZoom,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(markers: markers),
          ],
        ));
  }

  void showInfoDialog(BuildContext context,
      {required String title,
      required String description,
      required String imagePath}) {
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
