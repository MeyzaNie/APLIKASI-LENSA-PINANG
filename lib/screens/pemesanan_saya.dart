import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pemesanan_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/pengguna_provider.dart';

class PemesananSaya extends StatelessWidget {
  const PemesananSaya({super.key});

  void _konfirmasi(BuildContext context, String id) {
    Provider.of<PemesananProvider>(context, listen: false).konfirmasiKehadiran(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(backgroundColor: Colors.green, content: Text('Konfirmasi kehadiran berhasil')),
    );
  }

  void _selesaikan(BuildContext context, String id) {
    Provider.of<PemesananProvider>(context, listen: false).selesaikanKunjungan(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kunjungan selesai, terima kasih')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final pemesananProvider = Provider.of<PemesananProvider>(context);
    final penggunaProvider = Provider.of<PenggunaProvider>(context);
    final listPesan = pemesananProvider.getPemesananByUser(auth.pengguna!.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Background sedikit abu-abu agar kartu putih terlihat
      appBar: AppBar(
        title: const Text(
          'Daftar Reservasi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'Bayar di Tempat',
                style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: listPesan.isEmpty
          ? const Center(child: Text("Belum ada pemesanan"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listPesan.length,
              itemBuilder: (ctx, i) {
                final p = listPesan[i];
                
                // Mapping warna status agar mirip desain
                Color statusColor = p.status == 'pending' ? Colors.orange : Colors.green;
                String statusLabel = p.status == 'pending' ? 'BOOKED' : 'CONFIRMED';

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Gambar bulat kecil
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              p.destinasiGambar, // Pastikan model Pemesanan punya field gambar
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 50, height: 50, color: Colors.blue[100],
                                child: const Icon(Icons.image, color: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // 2. Judul dan Badge Status
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      p.destinasiNama,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        statusLabel,
                                        style: TextStyle(color: statusColor, fontSize: 9, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Paket Kunjungan Standard", // Subtitle statis sesuai desain
                                  style: TextStyle(color: Colors.grey[400], fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // 3. Baris Informasi Berwarna
                      _buildDetailRow(Icons.circle, Colors.red, "2026-05-20 08:00-10:00 (2 jam)"),
                      const SizedBox(height: 8),
                      _buildDetailRow(Icons.circle, Colors.blue, "Paket Keluarga - Maskimal 6 orang"),
                      const SizedBox(height: 8),
                      _buildDetailRow(Icons.circle, const Color(0xFFAED581), "Rp ${p.totalHarga}"), // Warna hijau muda sesuai gambar

                      const SizedBox(height: 16),
                      
                      // 4. Baris Tombol Aksi (3 Tombol)
                      Row(
                        children: [
                          _buildActionButton("Konfirmasi", p.status == 'pending' ? () => _konfirmasi(context, p.id) : null),
                          const SizedBox(width: 8),
                          _buildActionButton("Check-in & Bayar", null), // Placeholder sesuai gambar
                          const SizedBox(width: 8),
                          _buildActionButton("Selesaikan", p.status == 'ongoing' ? () => _selesaikan(context, p.id) : null),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // Fungsi helper untuk baris detail (dengan titik warna)
  Widget _buildDetailRow(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, size: 8, color: color),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(color: Colors.grey[400], fontSize: 12),
        ),
      ],
    );
  }

  // Fungsi helper untuk tombol aksi (3 kolom)
  Widget _buildActionButton(String label, VoidCallback? action) {
    bool isActive = action != null;
    return Expanded(
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? const Color(0xFFF1F3F4) : const Color(0xFFF8F9FA),
          foregroundColor: isActive ? Colors.black87 : Colors.grey[300],
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.withOpacity(0.05)),
          ),
        ),
        child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
