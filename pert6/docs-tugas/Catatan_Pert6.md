# Pertemuan 6 — Navigasi, Tema, dan Animasi Flutter

## Deskripsi
Pertemuan 6 membahas penerapan navigasi halaman, pengaturan tema, dan animasi pada aplikasi mobile menggunakan Flutter. Praktikum ini menggabungkan beberapa fitur untuk membuat aplikasi lebih interaktif dan nyaman digunakan.

## Tujuan
- Memahami navigasi halaman menggunakan `Navigator` dan named routes.
- Menerapkan animasi implisit dan eksplisit pada widget.
- Menggunakan `Hero` untuk animasi perpindahan antarhalaman.
- Mengatur tema terang dan gelap serta pilihan warna aplikasi.
- Menangani navigasi menuju halaman yang tidak ditemukan.

## Praktikum
Pada praktikum ini, aplikasi dikembangkan dengan beberapa fitur, yaitu:
- **Pengaturan tema:** mengganti mode terang dan gelap serta warna tema menggunakan `shared_preferences` agar pilihan tersimpan.
- **Navigasi halaman:** membuka halaman detail menggunakan named routes.
- **Animasi halaman:** menggunakan `FadeTransition` dan `Hero`.
- **Animasi widget:** menerapkan `AnimatedContainer`, `AnimatedSwitcher`, `RotationTransition`, dan `AnimatedOpacity`.
- **Navigasi tab:** menggunakan `IndexedStack`, `Drawer`, dan `NavigationBar`.
- **Halaman 404:** menampilkan halaman khusus ketika pengguna membuka rute yang tidak tersedia.

## Teknologi
- Flutter
- Dart
- Android Studio
- `shared_preferences`

## Cara Menjalankan
1. Buka folder proyek praktikum melalui Android Studio.
2. Buka Terminal pada direktori proyek.
3. Jalankan perintah berikut:

   ```bash
   flutter pub get
   flutter run
   ```

## Kesimpulan
Melalui praktikum ini, mahasiswa mempelajari penerapan navigasi, pengaturan tema, dan berbagai jenis animasi pada Flutter. Fitur-fitur tersebut membantu menghasilkan aplikasi yang lebih interaktif, terstruktur, dan mudah digunakan.