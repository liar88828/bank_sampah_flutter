import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Sampah Ceria Sejahtera'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang di Bank Sampah Ceria Sejahtera',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Tentang Kami',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Bank Sampah Ceria Sejahtera adalah solusi inovatif untuk menciptakan lingkungan yang lebih bersih dan sehat. Kami mengajak masyarakat untuk mengelola sampah dengan bijak melalui sistem tabungan sampah.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Layanan Kami',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('- Tabungan Sampah: Tukarkan sampah Anda dengan uang yang dapat ditabung.'),
                Text('- Edukasi Lingkungan: Pelatihan dan seminar tentang pengelolaan sampah yang ramah lingkungan.'),
                Text('- Daur Ulang Kreatif: Mengubah sampah menjadi produk yang bernilai ekonomi.'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Cara Kerja',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1. Kumpulkan Sampah: Pisahkan sampah organik dan anorganik di rumah Anda.'),
                Text('2. Setor ke Bank Sampah: Bawa sampah Anda ke Bank Sampah Ceria Sejahtera untuk ditimbang.'),
                Text('3. Dapatkan Poin: Tukarkan sampah Anda dengan poin yang bisa diuangkan atau digunakan untuk berbagai kebutuhan.'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Bergabunglah Sekarang!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Daftar sebagai anggota Bank Sampah Ceria Sejahtera dan jadilah bagian dari perubahan positif untuk lingkungan. Bersama kita bisa menciptakan masa depan yang lebih hijau dan bersih.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Hubungi Kami',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alamat: Jl. Raya Gunungpati No.KM.15, Nongkosawit, Kec. Gn. Pati, Kota Semarang, Jawa Tengah 50224 '),
                Text('Telepon: (024) 850 5680'),
                Text('Email: fk@unwahas.ac.id'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

