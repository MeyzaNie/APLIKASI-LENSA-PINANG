import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RegistrasiScreen extends StatefulWidget {
  @override
  _RegistrasiScreenState createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _role = 'user';
  bool _isLoading = false;

  // FUNGSI TETAP SAMA (TIDAK BERUBAH)
  Future<void> _register() async {
    setState(() => _isLoading = true);
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .registrasi(_namaController.text, _emailController.text, _passwordController.text, _role);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar yang lebih modern
      appBar: AppBar(
        title: Text('Daftar Akun', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView( // Agar tidak error saat keyboard muncul
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            // Header Kecil
            Icon(Icons.person_add_rounded, size: 80, color: Colors.blue[800]),
            SizedBox(height: 10),
            Text("Lensa Pinang", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[800])),
            SizedBox(height: 30),

            // Input Nama
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 15),

            // Input Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 15),

            // Input Password
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 15),

            // Dropdown Role
            DropdownButtonFormField<String>(
              value: _role,
              decoration: InputDecoration(
                labelText: 'Daftar Sebagai',
                prefixIcon: Icon(Icons.supervised_user_circle),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: ['user', 'owner'].map((e) => DropdownMenuItem(
                value: e, 
                child: Text(e == 'user' ? 'Wisatawan' : 'Pemilik Destinasi')
              )).toList(),
              onChanged: (v) => setState(() => _role = v!),
            ),
            
            SizedBox(height: 30),

            // Tombol Daftar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: _isLoading 
                ? Center(child: CircularProgressIndicator()) 
                : ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('DAFTAR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
