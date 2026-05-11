import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/destinasi_provider.dart';
import 'providers/pemesanan_provider.dart';
import 'providers/pengguna_provider.dart';
import 'screens/jelajah_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registrasi_screen.dart';
import 'screens/beranda_user.dart';
import 'screens/beranda_owner.dart';
import 'screens/beranda_admin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DestinasiProvider()),
        ChangeNotifierProvider(create: (_) => PemesananProvider()),
        ChangeNotifierProvider(create: (_) => PenggunaProvider()),
      ],
      child: MaterialApp(
        title: 'Booking Destinasi',
        theme: ThemeData(primarySwatch: Colors.green),
        initialRoute: '/',
        routes: {
          '/': (context) => Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  if (auth.pengguna != null) {
                    switch (auth.pengguna!.role) {
                      case 'owner':
                        return BerandaOwner();
                      case 'admin':
                        return BerandaAdmin();
                      default:
                        return BerandaUser();
                    }
                  }
                  return JelajahScreen();
                },
              ),
          '/login': (context) => LoginScreen(),
          '/registrasi': (context) => RegistrasiScreen(),
        },
      ),
    );
  }
}