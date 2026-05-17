Nama: Fajar Kurnia Putra 
Kelas: SIB 2F 
Absen: 09 
Nim: 244107060074 
Pemrograman Mobile Jobsheet Week 12

# 🌤️ Weather App (Aplikasi Prakiraan Cuaca)

Aplikasi Flutter sederhana untuk memantau cuaca saat ini dan prakiraan cuaca per jam menggunakan data dari **Open-Meteo API**.

---

## 🚀 Langkah-Langkah Pengerjaan

Berikut adalah langkah singkat pembuatan proyek ini:

### 1. Menambahkan Package Dependensi
Tambahkan package `http` (untuk mengambil data dari internet) dan `intl` (untuk memformat waktu/jam) di terminal:
```bash
flutter pub add http intl
```

### 2. Membuat Weather Model (`weather_model.dart`)
Membuat model data untuk mengubah format data JSON dari API Open-Meteo menjadi objek Dart yang aman digunakan di Flutter.

### 3. Membuat API Client (`api_client.dart`)
Membuat fungsi untuk mengambil (fetch) data cuaca dari API Open-Meteo dengan koordinat wilayah tertentu (misalnya, London).

### 4. Membangun UI Utama (`main.dart`)
Menyusun tampilan aplikasi dengan tema gelap (dark mode), ikon cuaca dinamis, suhu saat ini, kecepatan angin, dan prakiraan cuaca per jam secara horizontal.

---

## 📸 Hasil Akhir (Result)

Setelah aplikasi berhasil dijalankan, aplikasi akan menampilkan data cuaca secara real-time seperti gambar berikut:

![Hasil Akhir Aplikasi Cuaca](image.png)

---

## 📝 Kesimpulan

Proyek **Weather App** ini berhasil menghubungkan aplikasi **Flutter** dengan **Open-Meteo API** menggunakan package `http`. Dengan struktur data Model dan API Client yang aman dari crash (casting double), aplikasi dapat menampilkan informasi cuaca saat ini serta ramalan cuaca per jam secara asinkron dengan loading yang mulus.
