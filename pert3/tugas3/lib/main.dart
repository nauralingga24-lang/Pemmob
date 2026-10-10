import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Barang {
  String nama;
  int jumlah;
  String kategori;
  bool sudahDibeli;

  Barang(
      this.nama,
      this.jumlah,
      this.kategori, {
        this.sudahDibeli = false,
      });
}

class BelanjaModel extends ChangeNotifier {
  final List<Barang> _items = [];

  List<Barang> get items => List.unmodifiable(_items);

  int get jumlahBelumDibeli =>
      _items.where((barang) => !barang.sudahDibeli).length;

  void tambah(
      String nama,
      int jumlah,
      String kategori,
      ) {
    _items.add(
      Barang(
        nama,
        jumlah,
        kategori,
      ),
    );

    notifyListeners();
  }

  void toggle(int index) {
    _items[index].sudahDibeli =
    !_items[index].sudahDibeli;

    notifyListeners();
  }

  void hapus(int index) {
    _items.removeAt(index);

    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BelanjaModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Belanja',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const BelanjaPage(),
    );
  }
}

class BelanjaPage extends StatelessWidget {
  const BelanjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BelanjaModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Belanja (${model.jumlahBelumDibeli})',
        ),
      ),

      body: model.items.isEmpty
          ? const Center(
        child: Text(
          'Belum ada barang',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (context, i) {
          final barang = model.items[i];

          return ListTile(
            leading: Checkbox(
              value: barang.sudahDibeli,
              onChanged: (_) {
                context
                    .read<BelanjaModel>()
                    .toggle(i);
              },
            ),

            title: Text(
              barang.nama,
              style: TextStyle(
                decoration: barang.sudahDibeli
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),

            subtitle: Text(
              '${barang.jumlah} • ${barang.kategori}',
            ),

            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context
                    .read<BelanjaModel>()
                    .hapus(i);
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TambahBarangPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TambahBarangPage extends StatefulWidget {
  const TambahBarangPage({super.key});

  @override
  State<TambahBarangPage> createState() =>
      _TambahBarangPageState();
}

class _TambahBarangPageState
    extends State<TambahBarangPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();

  String? _kategori;

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nama = _namaController.text.trim();

    final jumlah = int.parse(
      _jumlahController.text.trim(),
    );

    context.read<BelanjaModel>().tambah(
      nama,
      jumlah,
      _kategori!,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Barang'),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama barang',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Nama barang wajib diisi';
                }

                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Jumlah wajib diisi';
                }

                final jumlah = int.tryParse(
                  value.trim(),
                );

                if (jumlah == null || jumlah <= 0) {
                  return 'Jumlah harus lebih dari 0';
                }

                return null;
              },
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              initialValue: _kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Makanan',
                  child: Text('Makanan'),
                ),
                DropdownMenuItem(
                  value: 'Minuman',
                  child: Text('Minuman'),
                ),
                DropdownMenuItem(
                  value: 'Lainnya',
                  child: Text('Lainnya'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _kategori = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Kategori wajib dipilih';
                }

                return null;
              },
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: _simpan,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}