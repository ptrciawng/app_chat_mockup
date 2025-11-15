Flutter Gemini Chat Mockup

Sebuah aplikasi chat sederhana yang dibangun menggunakan **Flutter** untuk mengintegrasikan model bahasa **Gemini** dari Google. Proyek ini menggunakan paket **`dash_chat_2`** untuk antarmuka pengguna (UI) chat yang responsif dan **`flutter_gemini`** untuk koneksi API.

Aplikasi ini mendemonstrasikan fitur *streaming* respons, di mana balasan dari Gemini muncul secara bertahap seperti efek mengetik.

Fitur Utama
Real-time Chat: Pengiriman pesan dan penerimaan respons yang cepat.
Streaming Response: Respons dari Gemini dikirim secara bertahap (chunk-by-chunk) untuk pengalaman pengguna yang lebih dinamis.
DashChat 2 UI: Menggunakan komponen UI chat yang *powerful* dan modern.

---

Persyaratan & Setup

1. Klon Repositori

```bash
git clone [https://www.youtube.com/playlist?list=PL681svw48Al7-I-liJN2nJudsnR4bY2Pc](https://www.youtube.com/playlist?list=PL681svw48Al7-I-liJN2nJudsnR4bY2Pc)
cd flutter-gemini-chat-mockup

2. Instal Dependensi
Pastikan semua paket terinstal, termasuk versi terbaru yang stabil:
Bash
flutter pub get

3. Dapatkan Gemini API Key
Anda memerlukan kunci API dari Google AI Studio untuk menjalankan aplikasi ini.
Buka Google AI Studio dan buat Kunci API baru.
Salin kunci tersebut.

4. Konfigurasi Kunci API (Wajib)
Kunci API harus diinisialisasi di file lib/main.dart.
Buka lib/main.dart dan pastikan kode Anda terlihat seperti ini, ganti placeholder dengan Kunci API Anda:
Dart

// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'home_page.dart';

void main() {
  Gemini.init(
    apiKey: "GANTI_DENGAN_KUNCI_API_ANDA",
    // Anda juga dapat mengatur model default jika diperlukan
    // model: 'gemini-2.5-flash', 
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

Menjalankan Aplikasi
Setelah konfigurasi selesai, jalankan aplikasi di perangkat virtual atau fisik:
Bash
flutter run