import 'package:flutter/material.dart';
import 'package:objek_wisata1/screen/berita.dart';
import 'package:objek_wisata1/screen/dashboard_screen.dart';
import 'package:objek_wisata1/screen/destinasi_alam.dart';
import 'package:objek_wisata1/screen/galeri.dart';
import 'package:objek_wisata1/screen/kebudayaan_detail.dart';
import 'package:objek_wisata1/screen/login_screen.dart';
import 'package:objek_wisata1/screen/team.dart'; 

class KebudayaanScreen extends StatelessWidget {
  const KebudayaanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo.png', // Replace with your logo asset
              height: 55,
            ),
            const SizedBox(width: 10),
            const Text('KEBUDAYAAN'),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3E5FC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RumahAdatScreen()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    'assets/images/rumah_adat.jpg', // Replace with your image asset
                    fit: BoxFit.cover,
                    height: 210,
                    width: 350,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    'assets/images/baju_adat.jpg', // Replace with your image asset
                    fit: BoxFit.cover,
                    height: 210,
                    width: 350,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    'assets/images/tari_adat.jpg', // Replace with your image asset
                    fit: BoxFit.cover,
                    height: 210,
                    width: 350,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFB3E5FC),
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 85, 81, 81),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Team',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1:
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return const OtherOptionScreen();
                },
              );
              break;
            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const GaleriScreen()),
              );
              break;
            case 3:
              // Navigate to Profile
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TeamPage()),
              );
              break;
          }
        },
      ),
    );
  }
}

class OtherOptionScreen extends StatelessWidget {
  const OtherOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_rounded, color: Colors.black, size: 30),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 60,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.exit_to_app, color: Colors.black, size: 30),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        color: Colors.white, // Latar belakang putih
                        child: Column(
                          children: [
                            _buildMenuTile(
                              context,
                              title: 'DESTINASI WISATA',
                              subMenus: [
                                'Alam',
                                'Taman',
                                'Tempat Hiburan',
                                'Peninggalan Sejarah'
                              ],
                            ),
                            const Divider(),
                            _buildMenuTile(context, title: 'KEBUDAYAAN', isLink: true, targetPage: const KebudayaanScreen()),
                            const Divider(),
                            _buildMenuTile(context, title: 'BERITA', isLink: true, targetPage: const BeritaScreen()),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(BuildContext context, {required String title, List<String>? subMenus, bool isLink = false, Widget? targetPage}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: subMenus != null
          ? ExpansionTile(
              title: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: subMenus
                  .map((subMenu) => ListTile(
                        title: Text(subMenu),
                        onTap: () {
                          // Handle submenu item click
                          switch (subMenu) {
                            case 'Alam':
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const AlamScreen()),
                              );
                              break;
                            // Handle other submenus if needed
                          }
                        },
                      ))
                  .toList(),
            )
          : ListTile(
              title: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: isLink
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => targetPage!),
                      );
                    }
                  : null,
            ),
    );
  }
}
