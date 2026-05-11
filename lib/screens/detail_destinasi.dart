import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/destinasi.dart';
import '../providers/auth_provider.dart';
import '../providers/pemesanan_provider.dart';

class DetailDestinasi extends StatefulWidget {
  final Destinasi destinasi;
  DetailDestinasi({required this.destinasi});

  @override
  _DetailDestinasiState createState() => _DetailDestinasiState();
}

class _DetailDestinasiState extends State<DetailDestinasi> {
  DateTime _tanggalKunjungan = DateTime.now().add(Duration(days: 1));
  int _jumlah = 1;

  Future<void> _booking() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    if (auth.pengguna == null) {
      Navigator.pushNamed(context, '/login');
      return;
    }
    if (auth.pengguna!.role != 'user') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hanya wisatawan yang bisa booking')));
      return;
    }
    await Provider.of<PemesananProvider>(context, listen: false).buatPemesanan(
      userId: auth.pengguna!.id,
      destinasi: widget.destinasi,
      tanggalKunjungan: _tanggalKunjungan,
      jumlah: _jumlah,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking berhasil, silakan konfirmasi kehadiran sebelum datang')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.destinasi.nama)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.destinasi.gambarUrl),
            SizedBox(height: 10),
            Text(widget.destinasi.deskripsi, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Harga: Rp ${widget.destinasi.harga}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Fasilitas: ${widget.destinasi.fasilitas.join(', ')}'),
            SizedBox(height: 20),
            Text('Pilih Tanggal Kunjungan:'),
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(context: context, initialDate: _tanggalKunjungan, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 90)));
                if (date != null) setState(() => _tanggalKunjungan = date);
              },
              child: Text('${_tanggalKunjungan.day}/${_tanggalKunjungan.month}/${_tanggalKunjungan.year}'),
            ),
            Row(children: [Text('Jumlah orang: '), IconButton(onPressed: () => setState(() => _jumlah = _jumlah > 1 ? _jumlah - 1 : 1), icon: Icon(Icons.remove)), Text('$_jumlah'), IconButton(onPressed: () => setState(() => _jumlah++), icon: Icon(Icons.add))]),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _booking, child: Text('Booking Sekarang (Bayar di Tempat)')),
          ],
        ),
      ),
    );
  }
}