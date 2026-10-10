import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfilePage(),
                    ),
                  );
                },
                icon: const Icon(Icons.person),
                label: const Text('Profil'),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MenuPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.restaurant),
                label: const Text('Daftar Menu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 32,
                child: Icon(
                  Icons.person,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Lingga Naura Rediana',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '20240801055',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Makanan {
  final String nama;
  final int harga;
  final String deskripsi;

  const Makanan(
      this.nama,
      this.harga,
      this.deskripsi,
      );
}

const daftarMenu = [
  Makanan(
    'Nasi Goreng',
    15000,
    'Nasi goreng dengan telur dan sayuran.',
  ),
  Makanan(
    'Mie Ayam',
    12000,
    'Mie dengan ayam, sayuran, dan kuah.',
  ),
  Makanan(
    'Es Teh',
    4000,
    'Minuman teh manis dingin yang menyegarkan.',
  ),
  Makanan(
    'Ayam Bakar',
    20000,
    'Ayam bakar dengan bumbu khas.',
  ),
  Makanan(
    'Soto Ayam',
    18000,
    'Soto ayam dengan kuah gurih dan segar.',
  ),
  Makanan(
    'Bakso',
    16000,
    'Bakso sapi dengan kuah dan mie.',
  ),
  Makanan(
    'Es Jeruk',
    7000,
    'Minuman jeruk segar dengan es.',
  ),
];


String formatHarga(int harga) {
  return harga.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (match) => '${match.group(1)}.',
  );
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Menu'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: daftarMenu.length,
        itemBuilder: (context, index) {
          final item = daftarMenu[index];

          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.restaurant,
                size: 32,
              ),
              title: Text(
                item.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                'Rp ${formatHarga(item.harga)}',
              ),

              trailing: const Icon(
                Icons.chevron_right,
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(
                      makanan: item,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Makanan makanan;

  const DetailPage({
    super.key,
    required this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(makanan.nama),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.restaurant_menu,
                size: 80,
              ),

              const SizedBox(height: 16),

              Text(
                makanan.nama,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Rp ${formatHarga(makanan.harga)}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                makanan.deskripsi,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}