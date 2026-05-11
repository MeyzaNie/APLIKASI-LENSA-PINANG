import 'package:flutter/material.dart';
import 'jelajah_screen.dart';
import 'pemesanan_saya.dart';
import 'profil_screen.dart';

class BerandaUser extends StatefulWidget {
  @override
  _BerandaUserState createState() => _BerandaUserState();
}

class _BerandaUserState extends State<BerandaUser> {
  int _index = 0;
  final List<Widget> _pages = [
    JelajahScreen(),
    PemesananSaya(),
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
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Jelajah'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Pemesanan Saya'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}