import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pemesanan_provider.dart';
import '../providers/destinasi_provider.dart';
import '../providers/auth_provider.dart';

class VerifikasiKedatangan extends StatelessWidget {
  const VerifikasiKedatangan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final owner = Provider.of<AuthProvider>(context).pengguna!;
    final destProvider = Provider.of<DestinasiProvider>(context);
    final myDest = destProvider.getDestinasiByOwner(owner.id);
    final pemesananProvider = Provider.of<PemesananProvider>(context);
    final pesananOwner = pemesananProvider.getPemesananByOwner(owner.id, myDest);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Latar belakang abu-abu bersih sesuai gambar
      appBar: AppBar(
        title: const Text(
          'Daftar Reservasi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15, top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9), // Hijau soft penanda jenis pembayaran
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'Bayar di Tempat',
                style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: pesananOwner.isEmpty
          ? Center(
              child: Text(
                'Belum ada data reservasi.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: pesananOwner.length,
              itemBuilder: (ctx, i) {
                final p = pesananOwner[i];
                
                // Normalisasi status string ke lowercase agar pengecekan aman
                final String status = p.status.toString().toLowerCase();
                
                // Variabel bantu untuk mencocokkan kondisi alur laporan
                final bool isConfirmed = status == 'confirmed';
                final bool isCheckedIn = status == 'checked_in' || status == 'sukses' || status == 'completed';

                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bagian Atas: Gambar, Judul Destinasi, dan Badge Status
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.image, color: Colors.grey),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.destinasiNama,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Paket Kunjungan Standard',
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            // Badge Status Pojok Kanan Atas
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isConfirmed 
                                    ? const Color(0xFFE3F2FD) // Biru muda untuk confirmed
                                    : (isCheckedIn ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                p.status.toUpperCase(),
                                style: TextStyle(
                                  color: isConfirmed 
                                      ? Colors.blue.shade700 
                                      : (isCheckedIn ? Colors.green.shade700 : Colors.orange.shade700),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Bagian Tengah: Tiga Baris Indikator Bulat Sesuai Gambar Mockup
                        Row(
                          children: [
                            const Icon(Icons.circle, color: Colors.redAccent, size: 8),
                            const SizedBox(width: 10),
                            Text(
                              '2026-05-20 08:00-10:00 (2 jam)',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.circle, color: Colors.blueAccent, size: 8),
                            const SizedBox(width: 10),
                            Text(
                              'Paket Keluarga - Maksimal ${p.jumlah} orang',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.circle, color: Colors.greenAccent, size: 8),
                            const SizedBox(width: 10),
                            Text(
                              'Rp 25000',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Bagian Bawah: Tiga Tombol Sejajar Berdasarkan Logika Laporan
                        Row(
                          children: [
                            // 1. Tombol Konfirmasi (Indikator Langkah - Aktif/Menyala jika sudah lewat langkah awal)
                            Expanded(
                              child: Container(
                                height: 38,
                                decoration: BoxDecoration(
                                  color: (isConfirmed || isCheckedIn) ? Colors.blue.shade50 : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'Konfirmasi',
                                    style: TextStyle(
                                      color: (isConfirmed || isCheckedIn) ? Colors.blue.shade600 : Colors.grey.shade400, 
                                      fontWeight: FontWeight.bold, 
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            
                            // 2. Tombol Utama: Check-in & Bayar (LOGIKA ASLI KELOMPOK KAMU)
                            Expanded(
                              child: InkWell(
                                onTap: isConfirmed
                                    ? () {
                                        pemesananProvider.checkInDanBayar(p.id);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Check-in berhasil, pembayaran di tempat selesai')),
                                        );
                                      }
                                    : null,
                                child: Container(
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: isConfirmed ? const Color(0xFF5A8FCE) : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Check-in & Bayar',
                                      style: TextStyle(
                                        color: isConfirmed ? Colors.white : Colors.grey.shade400, 
                                        fontWeight: FontWeight.bold, 
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // 3. Tombol Selesaikan (Menyala Hijau jika Check-in sudah berhasil diproses)
                            Expanded(
                              child: Container(
                                height: 38,
                                decoration: BoxDecoration(
                                  color: isCheckedIn ? const Color(0xFFE8F5E9) : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    isCheckedIn ? 'Selesai ✓' : 'Selesaikan',
                                    style: TextStyle(
                                      color: isCheckedIn ? const Color(0xFF4CAF50) : Colors.grey.shade400, 
                                      fontWeight: FontWeight.bold, 
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
