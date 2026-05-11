import 'package:flutter/material.dart';
import '../models/pengguna.dart';

class PenggunaProvider extends ChangeNotifier {
  List<Pengguna> _pengguna = [
    Pengguna(id: 'u1', nama: 'Budi Wisatawan', email: 'user@test.com', password: '123', role: 'user'),
    Pengguna(id: 'o1', nama: 'Pak Wayan', email: 'owner@test.com', password: '123', role: 'owner'),
    Pengguna(id: 'a1', nama: 'Admin Sistem', email: 'admin@test.com', password: '123', role: 'admin'),
  ];

  List<Pengguna> get semuaPengguna => _pengguna;

  void tambahPengguna(Pengguna p) {
    _pengguna.add(p);
    notifyListeners();
  }

  void updatePengguna(Pengguna p) {
    final index = _pengguna.indexWhere((item) => item.id == p.id);
    if (index != -1) {
      _pengguna[index] = p;
      notifyListeners();
    }
  }

  void hapusPengguna(String id) {
    _pengguna.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void tambahPenalti(String userId, int poin) {
    final user = _pengguna.firstWhere((p) => p.id == userId);
    user.penalti += poin;
    notifyListeners();
  }
}