import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan LayoutBuilder agar kita bisa tahu ukuran layar secara dinamis
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView( // Mencegah error overflow
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      
                      // 1. Logo & Nama Aplikasi
                      Image.asset('assets/logo_lensa.png', height: 80),
                      const SizedBox(height: 10),
                      const Text(
                        'LENSA PINANG',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                      ),
                      const Text(
                        'EKSPLORASI TANJUNGPINANG',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),

                      const SizedBox(height: 40),

                      // 2. Diamond Grid Images (Gambar Belah Ketupat)
                      Center(
                        child: Transform.rotate(
                          angle: 0.785398, // 45 derajat
                          child: Container(
                            width: 180, // Ukuran disesuaikan agar pas di layar kecil
                            height: 180,
                            child: GridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(4, (index) {
                                return Transform.rotate(
                                  angle: -0.785398, // Meluruskan gambar kembali
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        // Menggunakan onboarding_1 sampai 4
                                        image: AssetImage('assets/images/onboarding_${index + 1}.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),

                      // 3. Dot Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildDot(const Color(0xFFFFADAD)),
                          _buildDot(const Color(0xFFFFD670)),
                          _buildDot(const Color(0xFFC1F0C1)),
                        ],
                      ),

                      const SizedBox(height: 50),

                      // 4. Tombol Get Started
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushReplacementNamed(context, '/registrasi'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5A8FCE),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                          ),
                          child: const Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // 5. Tombol Login
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFF5F5F5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: const Text('Login', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
