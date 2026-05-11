import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pemesanan_provider.dart';
import '../providers/destinasi_provider.dart';
import '../providers/auth_provider.dart';

class VerifikasiKedatangan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final owner = Provider.of<AuthProvider>(context).pengguna!;
    final destProvider = Provider.of<DestinasiProvider>(context);
    final myDest = destProvider.getDestinasiByOwner(owner.id);
    final pemesananProvider = Provider.of<PemesananProvider>(context);
    final pesananOwner = pemesananProvider.getPemesananByOwner(owner.id, myDest);

    return Scaffold(
      appBar: AppBar(title: Text('Verifikasi Check-in & Bayar')),
      body: ListView.builder(
        itemCount: pesananOwner.length,
        itemBuilder: (ctx, i) {
          final p = pesananOwner[i];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(p.destinasiNama),
              subtitle: Text('Status: ${p.status} | Jumlah: ${p.jumlah} org'),
              trailing: p.status == 'confirmed'
                  ? ElevatedButton(
                      onPressed: () {
                        pemesananProvider.checkInDanBayar(p.id);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Check-in berhasil, pembayaran di tempat selesai')));
                      },
                      child: Text('Check-in & Bayar'),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}