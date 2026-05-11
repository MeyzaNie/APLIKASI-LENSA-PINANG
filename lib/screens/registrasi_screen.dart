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
      appBar: AppBar(title: Text('Registrasi')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _namaController, decoration: InputDecoration(labelText: 'Nama')),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            DropdownButtonFormField<String>(
              value: _role,
              items: ['user', 'owner'].map((e) => DropdownMenuItem(value: e, child: Text(e == 'user' ? 'Wisatawan' : 'Pemilik Destinasi'))).toList(),
              onChanged: (v) => setState(() => _role = v!),
            ),
            SizedBox(height: 20),
            _isLoading ? CircularProgressIndicator() : ElevatedButton(onPressed: _register, child: Text('Daftar')),
          ],
        ),
      ),
    );
  }
}