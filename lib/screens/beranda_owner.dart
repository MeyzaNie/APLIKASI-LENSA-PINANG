import 'package:flutter/material.dart';
import 'kelola_destinasi.dart';
import 'verifikasi_kedatangan.dart';
import 'profil_screen.dart';

class BerandaOwner extends StatefulWidget {
  @override
  _BerandaOwnerState createState() => _BerandaOwnerState();
}

class _BerandaOwnerState extends State<BerandaOwner> {
  int _index = 0;
  final List<Widget> _pages = [
    KelolaDestinasi(),
    VerifikasiKedatangan(),
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
          BottomNavigationBarItem(icon: Icon(Icons.home_work), label: 'Destinasiku'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Verifikasi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}