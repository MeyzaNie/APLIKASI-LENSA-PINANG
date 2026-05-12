import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Logo & Nama Aplikasi
              Image.asset('assets/logo_lensa.png', height: 80), // Sesuaikan nama file logo kamu
              const SizedBox(height: 10),
              const Text(
                'LENSA PINANG',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
              const Text(
                'EKSPLORASI TANJUNGPINANG',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),

              const SizedBox(height: 50),

              // 2. Diamond Grid Images (Gambar Belah Ketupat)
              // Kita pakai Transform.rotate untuk memutar kotak gambar
              Center(
                child: Transform.rotate(
                  angle: 0.785398, // 45 derajat dalam radian
                  child: Container(
                    width: 220,
                    height: 220,
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(4, (index) {
                        return Transform.rotate(
                          angle: -0.785398, // Putar balik gambarnya agar tidak miring
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage('assets/images/onboarding_$index.jpg'),
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

              const SizedBox(height: 40),

              // 3. Dot Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(Colors.red[200]!),
                  _buildDot(Colors.orange[300]!),
                  _buildDot(Colors.green[200]!),
                ],
              ),

              const SizedBox(height: 60),

              // 4. Tombol Get Started
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/registrasi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A8FCE), // Biru sesuai gambar
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                    backgroundColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text('Login', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
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
