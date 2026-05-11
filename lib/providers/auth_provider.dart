import 'package:flutter/material.dart';
import '../models/pengguna.dart';

class AuthProvider extends ChangeNotifier {
  Pengguna? _pengguna;
  Pengguna? get pengguna => _pengguna;

  // Data mock
  final List<Pengguna> _daftarPengguna = [
    Pengguna(id: 'u1', nama: 'Budi Wisatawan', email: 'user@test.com', password: '123', role: 'user'),
    Pengguna(id: 'o1', nama: 'Pak Wayan', email: 'owner@test.com', password: '123', role: 'owner'),
    Pengguna(id: 'a1', nama: 'Admin Sistem', email: 'admin@test.com', password: '123', role: 'admin'),
  ];

  Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(milliseconds: 500));
    final pengguna = _daftarPengguna.firstWhere(
      (p) => p.email == email && p.password == password,
      orElse: () => throw Exception('Email atau password salah'),
    );
    _pengguna = pengguna;
    notifyListeners();
    return true;
  }

  Future<bool> registrasi(String nama, String email, String password, String role) async {
    await Future.delayed(Duration(milliseconds: 500));
    final ada = _daftarPengguna.any((p) => p.email == email);
    if (ada) throw Exception('Email sudah terdaftar');
    final baru = Pengguna(
      id: 'u${_daftarPengguna.length + 1}',
      nama: nama,
      email: email,
      password: password,
      role: role,
    );
    _daftarPengguna.add(baru);
    _pengguna = baru;
    notifyListeners();
    return true;
  }

  void logout() {
    _pengguna = null;
    notifyListeners();
  }
}