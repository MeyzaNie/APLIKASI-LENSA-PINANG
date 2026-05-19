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
  int _index = 2; // Default langsung aktif ke halaman Verifikasi sesuai gambar

  final List<Widget> _pages = [
    KelolaPengguna(),
    KelolaDestinasiAdmin(),
    KelolaPemesananAdmin(),
    ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR KOTAK PUTIH ATAS DIHAPUS DARI SINI AGAR TIDAK TUMPANG TINDIH
      body: _pages[_index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF4A709C),
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              activeIcon: Icon(Icons.group),
              label: 'Pengguna',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              activeIcon: Icon(Icons.map),
              label: 'Destinasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner),
              label: 'Verifikasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
