import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 5',
      debugShowCheckedModeBanner: false,
      home: const PengaturanPage(),
    );
  }
}

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  final _controller = TextEditingController();
  bool _gelap = false;
  int _bukaKe = 0;

  @override
  void initState() {
    super.initState();
    _muat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _muat() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _controller.text = prefs.getString('nama') ?? '';
      _gelap = prefs.getBool('gelap') ?? false;
      _bukaKe = (prefs.getInt('bukaKe') ?? 0) + 1;
    });

    await prefs.setInt('bukaKe', _bukaKe);
  }

  Future<void> _simpanNama() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'nama',
      _controller.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nama disimpan'),
      ),
    );
  }

  Future<void> _ubahTema(bool nilai) async {
    setState(() {
      _gelap = nilai;
    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('gelap', nilai);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness:
        _gelap ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pengaturan'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _simpanNama,
                child: const Text('Simpan nama'),
              ),
              SwitchListTile(
                title: const Text('Mode gelap'),
                value: _gelap,
                onChanged: _ubahTema,
              ),
              const SizedBox(height: 12),
              Text(
                'Aplikasi dibuka ke-$_bukaKe kali',
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CatatanPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.note),
                label: const Text('Buka Catatan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Catatan {
  final int? id;
  final String judul;
  final String isi;

  const Catatan({
    this.id,
    required this.judul,
    required this.isi,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
    };
  }

  factory Catatan.fromMap(Map<String, Object?> map) {
    return Catatan(
      id: map['id'] as int,
      judul: map['judul'] as String,
      isi: map['isi'] as String,
    );
  }
}

class DbHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    final path = p.join(
      await getDatabasesPath(),
      'catatan.db',
    );

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE catatan('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'judul TEXT NOT NULL, '
              'isi TEXT NOT NULL)',
        );
      },
    );

    return _db!;
  }

  static Future<int> tambah(Catatan catatan) async {
    final db = await database;

    return db.insert(
      'catatan',
      catatan.toMap(),
    );
  }

  static Future<List<Catatan>> semua() async {
    final db = await database;

    final rows = await db.query(
      'catatan',
      orderBy: 'id DESC',
    );

    return rows.map(Catatan.fromMap).toList();
  }

  static Future<int> ubah(Catatan catatan) async {
    final db = await database;

    return db.update(
      'catatan',
      catatan.toMap(),
      where: 'id = ?',
      whereArgs: [catatan.id],
    );
  }

  static Future<int> hapus(int id) async {
    final db = await database;

    return db.delete(
      'catatan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Catatan>> cari(String kata) async {
    final db = await database;

    final rows = await db.query(
      'catatan',
      where: 'judul LIKE ?',
      whereArgs: ['%$kata%'],
      orderBy: 'id DESC',
    );

    return rows.map(Catatan.fromMap).toList();
  }
}

class CatatanPage extends StatefulWidget {
  const CatatanPage({super.key});

  @override
  State<CatatanPage> createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  late Future<List<Catatan>> _future;

  final TextEditingController _searchController =
  TextEditingController();

  bool _terbaru = true;

  @override
  void initState() {
    super.initState();

    _muatUrutan();
    _future = DbHelper.semua();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _muatUrutan() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _terbaru = prefs.getBool('terbaru') ?? true;
    });
  }

  Future<void> _ubahUrutan(bool terbaru) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('terbaru', terbaru);

    if (!mounted) return;

    setState(() {
      _terbaru = terbaru;
      _muat();
    });
  }

  void _muat() {
    setState(() {
      if (_searchController.text.trim().isEmpty) {
        _future = DbHelper.semua();
      } else {
        _future = DbHelper.cari(
          _searchController.text.trim(),
        );
      }
    });
  }

  Future<void> _buka([Catatan? catatan]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormCatatanPage(
          catatan: catatan,
        ),
      ),
    );

    if (!mounted) return;

    _muat();
  }

  Future<void> _konfirmasiHapus(Catatan catatan) async {
    final hasil = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Hapus catatan ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (hasil == true) {
      await DbHelper.hapus(catatan.id!);

      if (!mounted) return;

      _muat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Saya'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              8,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari judul catatan',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchController.clear();
                    _muat();
                  },
                  icon: const Icon(Icons.clear),
                ),
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) {
                _muat();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Urutan:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<bool>(
                  value: _terbaru,
                  items: const [
                    DropdownMenuItem(
                      value: true,
                      child: Text('Terbaru'),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text('Terlama'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      _ubahUrutan(value);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Catatan>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Galat: ${snapshot.error}',
                    ),
                  );
                }

                final data = snapshot.data ?? [];

                if (data.isEmpty) {
                  return const Center(
                    child: Text('Belum ada catatan'),
                  );
                }

                var daftar =
                List<Catatan>.from(data);

                if (!_terbaru) {
                  daftar = daftar.reversed.toList();
                }

                return ListView.builder(
                  itemCount: daftar.length,
                  itemBuilder: (context, index) {
                    final catatan = daftar[index];

                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          catatan.judul[0].toUpperCase(),
                        ),
                      ),
                      title: Text(catatan.judul),
                      subtitle: Text(
                        catatan.isi,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        _buka(catatan);
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _konfirmasiHapus(catatan);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _buka();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormCatatanPage extends StatefulWidget {
  final Catatan? catatan;

  const FormCatatanPage({
    super.key,
    this.catatan,
  });

  @override
  State<FormCatatanPage> createState() =>
      _FormCatatanPageState();
}

class _FormCatatanPageState
    extends State<FormCatatanPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _judul;
  late final TextEditingController _isi;

  @override
  void initState() {
    super.initState();

    _judul = TextEditingController(
      text: widget.catatan?.judul ?? '',
    );

    _isi = TextEditingController(
      text: widget.catatan?.isi ?? '',
    );
  }

  @override
  void dispose() {
    _judul.dispose();
    _isi.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final catatan = Catatan(
      id: widget.catatan?.id,
      judul: _judul.text.trim(),
      isi: _isi.text.trim(),
    );

    if (widget.catatan == null) {
      await DbHelper.tambah(catatan);
    } else {
      await DbHelper.ubah(catatan);
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final baru = widget.catatan == null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          baru ? 'Catatan Baru' : 'Ubah Catatan',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _judul,
              decoration: const InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Judul wajib diisi';
                }

                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _isi,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Isi catatan',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Isi wajib diisi';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),
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