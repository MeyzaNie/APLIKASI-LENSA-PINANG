// lib/utils/konstanta.dart

import 'package:flutter/material.dart';

class Warna {
  static const Color primary = Colors.green;
  static const Color secondary = Colors.orange;
  static const Color danger = Colors.red;
  static const Color warning = Colors.amber;
  static const Color success = Colors.green;
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF999999);
}

class Teks {
  static const String appTitle = 'Booking Destinasi';
  static const String loginTitle = 'Masuk ke Akun Anda';
  static const String registerTitle = 'Daftar Akun Baru';
  static const String exploreTitle = 'Jelajah Destinasi';
  static const String bookingSuccess = 'Booking berhasil! Silakan konfirmasi kehadiran sebelum datang.';
  static const String confirmSuccess = 'Konfirmasi kehadiran berhasil.';
  static const String checkinSuccess = 'Check-in berhasil, pembayaran di tempat selesai.';
  static const String completeSuccess = 'Kunjungan selesai, terima kasih.';
  static const String penaltyWarning = '⚠️ Penalti (No Show)';
  static const String onlyUserCanBook = 'Hanya wisatawan yang bisa melakukan booking.';
  static const String loginRequired = 'Silakan login terlebih dahulu.';
  static const String emailExists = 'Email sudah terdaftar.';
  static const String wrongCredential = 'Email atau password salah.';
  static const String deleteConfirm = 'Apakah Anda yakin ingin menghapus?';
  static const String emptyField = 'Harap isi semua field.';
}

class Ukuran {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double marginSmall = 8.0;
  static const double marginMedium = 16.0;
  static const double marginLarge = 24.0;
  static const double borderRadius = 12.0;
  static const double iconSize = 24.0;
  static const double avatarRadius = 40.0;
  static const double imageHeight = 200.0;
  static const double buttonHeight = 48.0;
}

class Format {
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String currencyFormat = 'Rp #,###';
}

class MockApi {
  // Gunakan placeholder image dari picsum (demo)
  static const String imageBaseUrl = 'https://picsum.photos/300/200?random=';
  static String getRandomImageUrl(int seed) => '$imageBaseUrl$seed';
  
  // Untuk production, ganti dengan endpoint asli
  static const String baseUrl = 'https://api.example.com/v1';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String destinationsEndpoint = '/destinations';
  static const String bookingsEndpoint = '/bookings';
}

class StatusPemesanan {
  static const String pending = 'pending';      // menunggu konfirmasi user
  static const String confirmed = 'confirmed';  // sudah dikonfirmasi user
  static const String ongoing = 'ongoing';      // sudah check-in oleh owner
  static const String completed = 'completed';  // sudah selesai kunjungan
  static const String noShow = 'no_show';       // tidak datang, kena penalti
  static const String cancelled = 'cancelled';  // dibatalkan
}

class Role {
  static const String user = 'user';
  static const String owner = 'owner';
  static const String admin = 'admin';
}

// Fungsi helper untuk format mata uang
String formatRupiah(double amount) {
  return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
}