class Pemesanan {
  final String id;
  final String userId;
  final String destinasiId;
  final String destinasiNama;
  final String destinasiGambar; // 1. TAMBAHKAN INI
  final DateTime tanggalKunjungan;
  final int jumlah;
  final double totalHarga;
  String status; // pending, confirmed, ongoing, completed, no_show
  final DateTime tanggalPesan;
  bool punyaPenalti;

  Pemesanan({
    required this.id,
    required this.userId,
    required this.destinasiId,
    required this.destinasiNama,
    required this.destinasiGambar, // 2. TAMBAHKAN JUGA DI SINI
    required this.tanggalKunjungan,
    required this.jumlah,
    required this.totalHarga,
    required this.status,
    required this.tanggalPesan,
    this.punyaPenalti = false,
  });
}
