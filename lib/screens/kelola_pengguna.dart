import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pengguna_provider.dart';

class KelolaPengguna extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final penggunaProvider = Provider.of<PenggunaProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Kelola Pengguna')),
      body: ListView.builder(
        itemCount: penggunaProvider.semuaPengguna.length,
        itemBuilder: (ctx, i) {
          final p = penggunaProvider.semuaPengguna[i];
          return ListTile(
            title: Text(p.nama),
            subtitle: Text('${p.email} | Role: ${p.role} | Penalti: ${p.penalti}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => penggunaProvider.hapusPengguna(p.id),
            ),
          );
        },
      ),
    );
  }
}