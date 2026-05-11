import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pemesanan_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/pengguna_provider.dart';

class PemesananSaya extends StatelessWidget {
  void _konfirmasi(BuildContext context, String id) {
    Provider.of<PemesananProvider>(context, listen: false).konfirmasiKehadiran(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Konfirmasi kehadiran berhasil')));
  }

  void _selesaikan(BuildContext context, String id) {
    Provider.of<PemesananProvider>(context, listen: false).selesaikanKunjungan(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kunjungan selesai, terima kasih')));
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final pemesananProvider = Provider.of<PemesananProvider>(context);
    final penggunaProvider = Provider.of<PenggunaProvider>(context);
    final listPesan = pemesananProvider.getPemesananByUser(auth.pengguna!.id);

    // Cek no show untuk penalti
    for (var p in listPesan) {
      if (p.status == 'pending' && p.tanggalKunjungan.isBefore(DateTime.now())) {
        pemesananProvider.terapkanPenalti(p.id);
        if (p.punyaPenalti) {
          penggunaProvider.tambahPenalti(auth.pengguna!.id, 1);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Pemesanan Saya')),
      body: ListView.builder(
        itemCount: listPesan.length,
        itemBuilder: (ctx, i) {
          final p = listPesan[i];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(p.destinasiNama),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tanggal: ${p.tanggalKunjungan.day}/${p.tanggalKunjungan.month}/${p.tanggalKunjungan.year}'),
                  Text('Status: ${p.status}'),
                  if (p.punyaPenalti) Text('⚠️ Penalti (No Show)', style: TextStyle(color: Colors.red)),
                ],
              ),
              trailing: p.status == 'pending'
                  ? ElevatedButton(onPressed: () => _konfirmasi(context, p.id), child: Text('Konfirmasi Kehadiran'))
                  : p.status == 'ongoing'
                      ? ElevatedButton(onPressed: () => _selesaikan(context, p.id), child: Text('Selesaikan Kunjungan'))
                      : null,
            ),
          );
        },
      ),
    );
  }
}