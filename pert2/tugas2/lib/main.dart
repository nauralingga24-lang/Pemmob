import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Kontak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const ContactPage(),
    );
  }
}

class Kontak {
  final String nama;
  final String telepon;
  final String email;

  const Kontak({
    required this.nama,
    required this.telepon,
    required this.email,
  });
}

const daftarKontak = [
  Kontak(
    nama: 'Lingga Naura',
    telepon: '081234567890',
    email: 'lingga@gmail.com',
  ),
  Kontak(
    nama: 'Khumaira',
    telepon: '082345678901',
    email: 'khuma@gmail.com',
  ),
  Kontak(
    nama: 'Mery Ismalia',
    telepon: '083456789012',
    email: 'mery@gmail.com',
  ),
  Kontak(
    nama: 'Adelia Rizky',
    telepon: '084567890123',
    email: 'adel@gmail.com',
  ),
  Kontak(
    nama: 'Fiery Ardiansyah',
    telepon: '085678901234',
    email: 'fiery@gmail.com',
  ),
  Kontak(
    nama: 'Naufal Febrian',
    telepon: '086789012345',
    email: 'naufal@gmail.com',
  ),
];

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: daftarKontak.length,
        itemBuilder: (context, index) {
          final kontak = daftarKontak[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(

              leading: CircleAvatar(
                child: Text(
                  kontak.nama[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              title: Text(
                kontak.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                kontak.telepon,
              ),

              trailing: const Icon(
                Icons.chevron_right,
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailKontakPage(
                      kontak: kontak,
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

class DetailKontakPage extends StatelessWidget {
  final Kontak kontak;

  const DetailKontakPage({
    super.key,
    required this.kontak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kontak'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CircleAvatar(
                radius: 50,
                child: Text(
                  kontak.nama[0],
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                kontak.nama,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone),
                  const SizedBox(width: 10),
                  Text(
                    kontak.telepon,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.email),
                  const SizedBox(width: 10),
                  Text(
                    kontak.email,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

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