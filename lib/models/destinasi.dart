class Destinasi {
  final String id;
  final String nama;
  final String deskripsi;
  final double harga;
  final String gambarUrl;
  final String pemilikId; // ID owner yang memiliki destinasi
  final List<String> fasilitas;

  Destinasi({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.gambarUrl,
    required this.pemilikId,
    required this.fasilitas,
  });
}