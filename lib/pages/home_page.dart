import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart'; 


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  
  // 💡 Ganti URL ini dengan gambar yang valid atau hapus saja
  ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini",
  profileImage: "https://static.wikia.nocookie.net/hellokitty/images/a/a5/Mv-cinnamon.png/revision/latest?cb=20250930161135"); 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "MockUP Chat",
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI(){
    return DashChat(
      inputOptions: InputOptions(trailing: [
        IconButton(
        onPressed: () {}, 
        icon: const Icon(
          Icons.image,
        ),
        )
      ]),
    currentUser: currentUser, 
    onSend: _sendMessage, 
    messages: messages);
  }

  void _sendMessage(ChatMessage chatMessage) {
    // 1. Tambahkan pesan pengguna ke UI
    setState(() {
      messages = [chatMessage, ...messages];
    });

    // 2. Buat pesan Gemini placeholder
    ChatMessage geminiMessage = ChatMessage(
      user: geminiUser,
      createdAt: DateTime.now(),
      text: "", // Dimulai dengan string kosong
    );
    
    // Tambahkan placeholder ke UI
    setState(() {
      messages = [geminiMessage, ...messages];
    });

    try {
      String question = chatMessage.text;
      
      // 3. Panggil API streaming Gemini
      gemini.streamGenerateContent(question).listen((event) {
        
        // Cek jika Gemini mengembalikan konten
        if (event.content != null && event.content!.parts != null) {
          
          // 4. Ambil potongan teks dari event (Perbaikan untuk masalah .text)
          String responseChunk = event.content!.parts!.fold(
            "",
            (previous, current) {
              // Mengakses properti 'text' secara aman, yang akan berfungsi 
              // di versi terbaru paket flutter_gemini setelah Anda memperbarui.
              if (current.text != null) { 
                  return "$previous${current.text!}";
              }
              return previous;
            },
          );

          // 5. Perbarui pesan Gemini placeholder
          setState(() {
            // Hapus pesan Gemini yang lama dari daftar
            messages.removeAt(0);
            
            // Tambahkan potongan teks ke pesan yang sudah ada
            geminiMessage.text += responseChunk;
            
            // Masukkan kembali pesan Gemini yang diperbarui di posisi 0
            messages = [geminiMessage, ...messages];
          });
        }
      });
    } catch (e) {
      // Menangani error jika koneksi gagal
      print("Error during Gemini stream: $e");
      
      // Hapus placeholder dan tampilkan pesan error
      setState(() {
        messages.removeWhere((msg) => msg.user == geminiUser);
        final errorMessage = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: "Maaf, terjadi kesalahan saat menghubungi Gemini. Pastikan API Key benar. ($e)",
        );
        messages = [errorMessage, ...messages];
      });
    }
  }
}