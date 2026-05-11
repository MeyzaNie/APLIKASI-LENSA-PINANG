import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/destinasi_provider.dart';
import 'detail_destinasi.dart';

class JelajahScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final destProvider = Provider.of<DestinasiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Jelajah Destinasi'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: Text('Login', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: destProvider.semuaDestinasi.length,
        itemBuilder: (ctx, i) {
          final d = destProvider.semuaDestinasi[i];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(d.gambarUrl, width: 60, height: 60, fit: BoxFit.cover),
              title: Text(d.nama),
              subtitle: Text('Rp ${d.harga} / orang'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailDestinasi(destinasi: d))),
            ),
          );
        },
      ),
    );
  }
}