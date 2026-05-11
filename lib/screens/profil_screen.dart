import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/pengguna_provider.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final pengguna = auth.pengguna!;
    final penggunaProvider = Provider.of<PenggunaProvider>(context);
    final currentUser = penggunaProvider.semuaPengguna.firstWhere((u) => u.id == pengguna.id);

    return Scaffold(
      appBar: AppBar(title: Text('Profil Saya')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            SizedBox(height: 10),
            Text(pengguna.nama, style: TextStyle(fontSize: 22)),
            Text(pengguna.email),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.warning),
                title: Text('Penalti: ${currentUser.penalti} poin'),
                subtitle: Text('Setiap no show akan menambah 1 poin penalti'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                auth.logout();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}