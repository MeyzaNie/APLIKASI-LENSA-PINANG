import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/pengguna_provider.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final pengguna = auth.pengguna!;
    final penggunaProvider = Provider.of<PenggunaProvider>(context);
    final currentUser = penggunaProvider.semuaPengguna.firstWhere((u) => u.id == pengguna.id);

    // Hitung tingkat kepatuhan berdasarkan poin penalti lama kamu
    // Kita asumsikan 100% kepatuhan jika 0 penalti, dan berkurang sesuai jumlah poin
    double tingkatKepatuhan = (1.0 - (currentUser.penalti * 0.1)).clamp(0.0, 1.0);
    String persentase = "${(tingkatKepatuhan * 100).toInt()}%";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Profil', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: Colors.blue[50],
              radius: 18,
              child: const Text('T&C', style: TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header Profil
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/300'), 
                  ),
                  const SizedBox(height: 16),
                  Text(pengguna.nama, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('Member Sejak Mar 2020', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 8),
                  // Badge Peringatan sesuai poin penalti lama
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8F1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Peringatan (${currentUser.penalti} poin)', 
                      style: const TextStyle(color: Color(0xFFE67E22), fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Kartu Statistik Kepatuhan
            _buildStatCard(
              title: 'Tingkat kepatuhan',
              value: persentase,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: tingkatKepatuhan,
                  minHeight: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2D7D5D)),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Info No-Show sesuai peraturan lama kamu
            _buildStatCard(
              title: 'No-show: ${currentUser.penalti}x',
              value: 'Info Penalti',
              valueStyle: const TextStyle(color: Colors.grey, fontSize: 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (currentUser.penalti / 5).clamp(0.0, 1.0), 
                      minHeight: 8,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Setiap no show akan menambah 1 poin penalti',
                    style: TextStyle(fontSize: 11, color: Colors.grey, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Tombol Logout
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  auth.logout();
                  Navigator.pushReplacementNamed(context, '/');
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Keluar Akun', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, required Widget child, TextStyle? valueStyle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(value, style: valueStyle ?? const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
