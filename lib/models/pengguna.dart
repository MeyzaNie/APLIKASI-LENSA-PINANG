class Pengguna {
  final String id;
  final String nama;
  final String email;
  final String password; // hanya untuk mock, jangan dipakai production
  final String role; // 'user', 'owner', 'admin'
  int penalti;

  Pengguna({
    required this.id,
    required this.nama,
    required this.email,
    required this.password,
    required this.role,
    this.penalti = 0,
  });
}