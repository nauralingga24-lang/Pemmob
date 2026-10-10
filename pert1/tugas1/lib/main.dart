import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartu Perkenalan',
      debugShowCheckedModeBanner: false,
      home: const IntroductionCard(),
    );
  }
}

class IntroductionCard extends StatelessWidget {
  const IntroductionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'Kartu Perkenalan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.pink,
            ),

            const SizedBox(height: 20),

            const Text(
              'Lingga Naura Rediana',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'NIM: 20240801055',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            const Text(
              'Teknik Informatika',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            const Text(
              'Hobi: Mendengarkan Musik',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}