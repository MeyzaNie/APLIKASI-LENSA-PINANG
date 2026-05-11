import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/destinasi_provider.dart';

class KelolaDestinasiAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final destProvider = Provider.of<DestinasiProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Kelola Semua Destinasi')),
      body: ListView.builder(
        itemCount: destProvider.semuaDestinasi.length,
        itemBuilder: (ctx, i) {
          final d = destProvider.semuaDestinasi[i];
          return ListTile(
            title: Text(d.nama),
            subtitle: Text('Pemilik ID: ${d.pemilikId} | Rp ${d.harga}'),
            trailing: IconButton(onPressed: () => destProvider.hapusDestinasi(d.id), icon: Icon(Icons.delete, color: Colors.red)),
          );
        },
      ),
    );
  }
}