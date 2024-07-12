import 'package:flutter/material.dart';

class DestinasiScreen extends StatelessWidget {
  const DestinasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Stack(
              children: [
                // Background Image
                Image.asset(
                  'assets/images/background.png', // Ganti dengan path gambar background yang Anda miliki
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                // Logo
                Positioned(
                  top: 16,
                  left: 16,
                  child: Image.asset(
                    'assets/images/logo.png', // Ganti dengan path logo yang Anda miliki
                    width: 60,
                  ),
                ),
                // Exit Icon
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.exit_to_app, color: Colors.white, size: 30),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            // Destinasi Wisata Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Destinasi Wisata',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildDestinationItem('assets/images/tanjung_pinang.png'),
                  _buildDestinationItem('assets/images/jembatan_layang.png'),
                  _buildDestinationItem('assets/images/air_terjun.png'),
                ],
              ),
            ),
            // Bottom Navigation Bar
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.image),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                ),
              ],
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}