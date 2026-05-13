import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pengguna_provider.dart';

class KelolaPengguna extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final penggunaProvider = Provider.of<PenggunaProvider>(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Warna latar belakang bersih
      appBar: AppBar(
        title: const Text(
          'Kelola Pengguna',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF5A8FCE), // Biru Lensa Pinang
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: penggunaProvider.semuaPengguna.length,
        itemBuilder: (ctx, i) {
          final p = penggunaProvider.semuaPengguna[i];
          
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Melengkung sesuai desain Onboarding
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF5A8FCE).withOpacity(0.1),
                child: const Icon(Icons.person, color: Color(0xFF5A8FCE)),
              ),
              title: Text(
                p.nama,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${p.email}\nRole: ${p.role} | Penalti: ${p.penalti}',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                // FUNGSI TETAP SAMA PERSIS
                onPressed: () => penggunaProvider.hapusPengguna(p.id),
              ),
            ),
          );
        },
      ),
    );
  }
}
