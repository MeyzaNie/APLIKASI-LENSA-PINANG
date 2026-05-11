import 'package:flutter/material.dart';
import '../models/destinasi.dart';

class DestinasiProvider extends ChangeNotifier {
  List<Destinasi> _destinasi = [
    Destinasi(
      id: 'd1',
      nama: 'Pantai Kuta',
      deskripsi: 'Pasir putih, ombak bagus, sunset indah.',
      harga: 25000,
      gambarUrl: 'https://picsum.photos/300/200?random=1',
      pemilikId: 'o1',
      fasilitas: ['Toilet', 'Parkir luas', 'Warung makan', 'Sewa kursi'],
    ),
    Destinasi(
      id: 'd2',
      nama: 'Gunung Bromo',
      deskripsi: 'Nikmati sunrise dari puncak gunung.',
      harga: 50000,
      gambarUrl: 'https://picsum.photos/300/200?random=2',
      pemilikId: 'o1',
      fasilitas: ['Jeep', 'Pemandu', 'Camping ground'],
    ),
  ];

  List<Destinasi> get semuaDestinasi => _destinasi;

  void tambahDestinasi(Destinasi d) {
    _destinasi.add(d);
    notifyListeners();
  }

  void updateDestinasi(Destinasi d) {
    final index = _destinasi.indexWhere((item) => item.id == d.id);
    if (index != -1) {
      _destinasi[index] = d;
      notifyListeners();
    }
  }

  void hapusDestinasi(String id) {
    _destinasi.removeWhere((d) => d.id == id);
    notifyListeners();
  }

  List<Destinasi> getDestinasiByOwner(String ownerId) {
    return _destinasi.where((d) => d.pemilikId == ownerId).toList();
  }
}