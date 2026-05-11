import 'package:flutter/material.dart';
import 'kelola_pengguna.dart';
import 'kelola_destinasi_admin.dart';
import 'kelola_pemesanan_admin.dart';
import 'profil_screen.dart';

class BerandaAdmin extends StatefulWidget {
  @override
  _BerandaAdminState createState() => _BerandaAdminState();
}

class _BerandaAdminState extends State<BerandaAdmin> {
  int _index = 0;
  final List<Widget> _pages = [
    KelolaPengguna(),
    KelolaDestinasiAdmin(),
    KelolaPemesananAdmin(),
    ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Pengguna'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Destinasi'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Pemesanan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}