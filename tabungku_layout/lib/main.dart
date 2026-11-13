
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TabungKu',
      home: const RingkasanPage(),
    );
  }
}

// Halaman ringkasan tabungan
class RingkasanPage extends StatelessWidget {
  const RingkasanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Judul halaman
      appBar: AppBar(
        title: const Text('Ringkasan Tabungan'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),

      // Halaman dapat di-scroll agar tidak overflow
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kartu ringkasan saldo dan target
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tabungan Pribadi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Informasi saldo dan target
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Saldo Saat Ini'),
                                const SizedBox(height: 5),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Rp 1.500.000',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Target Tabungan'),
                                const SizedBox(height: 5),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Rp 5.000.000',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Tiga ikon menu utama
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Menu Menabung
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: Colors.teal,
                          size: 40,
                        ),
                        SizedBox(height: 8),
                        Text('Menabung'),
                      ],
                    ),
                  ),

                  // Menu Tarik
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.remove_circle,
                          color: Colors.orange,
                          size: 40,
                        ),
                        SizedBox(height: 8),
                        Text('Tarik'),
                      ],
                    ),
                  ),

                  // Menu Riwayat
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.history,
                          color: Colors.blue,
                          size: 40,
                        ),
                        SizedBox(height: 8),
                        Text('Riwayat'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Judul daftar transaksi
              const Text(
                'Transaksi Terakhir',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // Daftar transaksi menggunakan data statis
              _transaksi(
                'Menabung Mingguan',
                '10 November 2026',
                '+ Rp 500.000',
                Colors.green,
              ),

              _transaksi(
                'Tarik Tabungan',
                '8 November 2026',
                '- Rp 200.000',
                Colors.red,
              ),

              _transaksi(
                'Menabung Bulanan',
                '5 November 2026',
                '+ Rp 1.200.000',
                Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan setiap transaksi
  Widget _transaksi(
      String judul,
      String tanggal,
      String nominal,
      Color warna,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Judul dan tanggal transaksi
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    tanggal,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Nominal transaksi
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                nominal,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: warna,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
