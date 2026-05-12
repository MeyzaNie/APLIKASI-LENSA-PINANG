import 'package:flutter/material.dart';
import '../models/pemesanan.dart';
import '../models/destinasi.dart';

class PemesananProvider extends ChangeNotifier {
  List<Pemesanan> _pemesanan = [];

  List<Pemesanan> get semuaPemesanan => _pemesanan;

  Future<void> buatPemesanan({
    required String userId,
    required Destinasi destinasi,
    required DateTime tanggalKunjungan,
    required int jumlah,
  }) async {
    final baru = Pemesanan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      destinasiId: destinasi.id,
      destinasiNama: destinasi.nama,
      // PERBAIKAN: Menggunakan 'gambarUrl' sesuai model Destinasi kamu
      destinasiGambar: destinasi.gambarUrl, 
      tanggalKunjungan: tanggalKunjungan,
      jumlah: jumlah,
      totalHarga: destinasi.harga * jumlah,
      status: 'pending',
      tanggalPesan: DateTime.now(),
    );
    _pemesanan.add(baru);
    notifyListeners();
  }

  List<Pemesanan> getPemesananByUser(String userId) {
    return _pemesanan.where((p) => p.userId == userId).toList();
  }

  List<Pemesanan> getPemesananByOwner(String ownerId, List<Destinasi> destinasiMilik) {
    final destIds = destinasiMilik.map((d) => d.id).toList();
    return _pemesanan.where((p) => destIds.contains(p.destinasiId)).toList();
  }

  void konfirmasiKehadiran(String idPemesanan) {
    final index = _pemesanan.indexWhere((p) => p.id == idPemesanan);
    if (index != -1 && _pemesanan[index].status == 'pending') {
      _pemesanan[index].status = 'confirmed';
      notifyListeners();
    }
  }

  void checkInDanBayar(String idPemesanan) {
    final index = _pemesanan.indexWhere((p) => p.id == idPemesanan);
    if (index != -1 && _pemesanan[index].status == 'confirmed') {
      _pemesanan[index].status = 'ongoing';
      notifyListeners();
    }
  }

  void selesaikanKunjungan(String idPemesanan) {
    final index = _pemesanan.indexWhere((p) => p.id == idPemesanan);
    if (index != -1 && _pemesanan[index].status == 'ongoing') {
      _pemesanan[index].status = 'completed';
      notifyListeners();
    }
  }

  void terapkanPenalti(String idPemesanan) {
    final index = _pemesanan.indexWhere((p) => p.id == idPemesanan);
    if (index != -1 && 
        _pemesanan[index].status == 'pending' && 
        _pemesanan[index].tanggalKunjungan.isBefore(DateTime.now())) {
      _pemesanan[index].status = 'no_show';
      _pemesanan[index].punyaPenalti = true;
      notifyListeners();
    }
  }

  // Untuk admin
  List<Pemesanan> getAllPemesanan() => _pemesanan;
}
