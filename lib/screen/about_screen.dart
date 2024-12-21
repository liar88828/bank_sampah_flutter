import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        // title: const Text('Bank Sampah Ceria Sejahtera'),
        // backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(

              'Selamat Datang di Bank Sampah Ceria Sejahtera',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,


              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Tentang Kami',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Bank Sampah Ceria Sejahtera adalah solusi inovatif untuk menciptakan lingkungan yang lebih bersih dan sehat. Kami mengajak masyarakat untuk mengelola sampah dengan bijak melalui sistem tabungan sampah.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Layanan Kami',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('- Tabungan Sampah: Tukarkan sampah Anda dengan uang yang dapat ditabung.'),
                Text('- Edukasi Lingkungan: Pelatihan dan seminar tentang pengelolaan sampah yang ramah lingkungan.'),
                Text('- Daur Ulang Kreatif: Mengubah sampah menjadi produk yang bernilai ekonomi.'),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Cara Kerja',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('1. Kumpulkan Sampah: Pisahkan sampah organik dan anorganik di rumah Anda.'),
                Text('2. Setor ke Bank Sampah: Bawa sampah Anda ke Bank Sampah Ceria Sejahtera untuk ditimbang.'),
                // Text('3. Dapatkan Poin: Tukarkan sampah Anda dengan poin yang bisa diuangkan atau digunakan untuk berbagai kebutuhan.'),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Bergabunglah Sekarang!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Daftar sebagai anggota Bank Sampah Ceria Sejahtera dan jadilah bagian dari perubahan positif untuk lingkungan. Bersama kita bisa menciptakan masa depan yang lebih hijau dan bersih.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Hubungi Kami',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 8.0),
            Card(
              elevation: 4,
              color: Colors.green.shade50,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Alamat: Jl. Raya Gunungpati No.KM.15, Nongkosawit, Kec. Gn. Pati, Kota Semarang, Jawa Tengah 50224'),
                    SizedBox(height: 8.0),
                    Text('Telepon: (024) 850 5680'),
                    SizedBox(height: 8.0),
                    Text('Email: fk@unwahas.ac.id'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
