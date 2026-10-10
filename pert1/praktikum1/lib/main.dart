import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 1',
      debugShowCheckedModeBanner: false,
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  void _tambah() {
    setState(() {
      _count++;
    });
  }

  void _kurang() {
    if (_count > 0) {
      setState(() {
        _count--;
      });
    }
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'Counter Saya',
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
              Icons.flutter_dash,
              size: 80,
              color: Colors.redAccent,
            ),

            const SizedBox(height: 16),

            const Text(
              'Halo, Lingga Naura Rediana',
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 8),

            const Text(
              'NIM: 20240801055',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 30),

            Text(
              '$_count',
              style: const TextStyle(
                fontSize: 48,
                color: Colors.pink,
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _kurang,
                  child: const Icon(Icons.remove),
                ),

                const SizedBox(width: 15),

                ElevatedButton(
                  onPressed: _reset,
                  child: const Text('Reset'),
                ),

                const SizedBox(width: 15),

                ElevatedButton(
                  onPressed: _tambah,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}