import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pemesanan_provider.dart';

class KelolaPemesananAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pemesananProvider = Provider.of<PemesananProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Semua Pemesanan')),
      body: ListView.builder(
        itemCount: pemesananProvider.semuaPemesanan.length,
        itemBuilder: (ctx, i) {
          final p = pemesananProvider.semuaPemesanan[i];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(p.destinasiNama),
              subtitle: Text('User: ${p.userId} | Tgl: ${p.tanggalKunjungan.day}/${p.tanggalKunjungan.month}/${p.tanggalKunjungan.year} | Status: ${p.status}'),
            ),
          );
        },
      ),
    );
  }
}