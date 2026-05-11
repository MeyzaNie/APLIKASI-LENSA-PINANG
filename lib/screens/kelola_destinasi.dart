import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/destinasi_provider.dart';
import '../providers/auth_provider.dart';
import '../models/destinasi.dart';

class KelolaDestinasi extends StatefulWidget {
  @override
  _KelolaDestinasiState createState() => _KelolaDestinasiState();
}

class _KelolaDestinasiState extends State<KelolaDestinasi> {
  void _tambah() {
    final ownerId = Provider.of<AuthProvider>(context, listen: false).pengguna!.id;
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text('Tambah Destinasi'),
        children: [
          _FormDestinasi(ownerId: ownerId, onSave: () => setState(() {})),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final owner = Provider.of<AuthProvider>(context).pengguna!;
    final destProvider = Provider.of<DestinasiProvider>(context);
    final myDest = destProvider.getDestinasiByOwner(owner.id);
    return Scaffold(
      appBar: AppBar(title: Text('Kelola Destinasi'), actions: [IconButton(onPressed: _tambah, icon: Icon(Icons.add))]),
      body: ListView.builder(
        itemCount: myDest.length,
        itemBuilder: (ctx, i) {
          final d = myDest[i];
          return ListTile(
            title: Text(d.nama),
            subtitle: Text('Rp ${d.harga}'),
            trailing: IconButton(onPressed: () => destProvider.hapusDestinasi(d.id), icon: Icon(Icons.delete, color: Colors.red)),
          );
        },
      ),
    );
  }
}

class _FormDestinasi extends StatefulWidget {
  final String ownerId;
  final VoidCallback onSave;
  _FormDestinasi({required this.ownerId, required this.onSave});
  @override
  __FormDestinasiState createState() => __FormDestinasiState();
}

class __FormDestinasiState extends State<_FormDestinasi> {
  final _nama = TextEditingController();
  final _desk = TextEditingController();
  final _harga = TextEditingController();
  final _fasilitas = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(controller: _nama, decoration: InputDecoration(labelText: 'Nama Destinasi')),
          TextField(controller: _desk, decoration: InputDecoration(labelText: 'Deskripsi')),
          TextField(controller: _harga, decoration: InputDecoration(labelText: 'Harga'), keyboardType: TextInputType.number),
          TextField(controller: _fasilitas, decoration: InputDecoration(labelText: 'Fasilitas (pisah koma)')),
          ElevatedButton(
            onPressed: () {
              final baru = Destinasi(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                nama: _nama.text,
                deskripsi: _desk.text,
                harga: double.parse(_harga.text),
                gambarUrl: 'https://picsum.photos/300/200?random=${DateTime.now().millisecondsSinceEpoch}',
                pemilikId: widget.ownerId,
                fasilitas: _fasilitas.text.split(','),
              );
              Provider.of<DestinasiProvider>(context, listen: false).tambahDestinasi(baru);
              widget.onSave();
              Navigator.pop(context);
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }
}