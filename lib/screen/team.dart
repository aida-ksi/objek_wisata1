import 'package:flutter/material.dart';
import 'package:objek_wisata1/screen/berita.dart';
import 'package:objek_wisata1/screen/dashboard_screen.dart';
import 'package:objek_wisata1/screen/destinasi_alam.dart';
import 'package:objek_wisata1/screen/galeri.dart';
import 'package:objek_wisata1/screen/kebudayaan.dart';
import 'package:objek_wisata1/screen/login_screen.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

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
            const Text('TEAM'),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3E5FC),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          teamMember(
            imageUrl: 'assets/images/aida.png',
            name: 'Nur Aida Azzuhra',
            role: 'Programmer',
            facebookUrl: 'https://facebook.com',
            twitterUrl: 'https://twitter.com',
            instagramUrl: 'https://instagram.com',
          ),
          const SizedBox(height: 20.0),
          teamMember(
            imageUrl: 'assets/images/nur.png',
            name: 'Nurasmawati',
            role: 'Desainer',
            facebookUrl: 'https://facebook.com',
            twitterUrl: 'https://twitter.com',
            instagramUrl: 'https://instagram.com',
          ),
          const SizedBox(height: 20.0),
          teamMember(
            imageUrl: 'assets/images/sani.png',
            name: 'Muhammad Sani',
            role: 'Programmer',
            facebookUrl: 'https://facebook.com',
            twitterUrl: 'https://twitter.com',
            instagramUrl: 'https://instagram.com',
          ),
          const SizedBox(height: 20.0),
          teamMember(
            imageUrl: 'assets/images/renki.jpeg',
            name: 'Renki Gunawan',
            role: 'Desainer',
            facebookUrl: 'https://facebook.com',
            twitterUrl: 'https://twitter.com',
            instagramUrl: 'https://instagram.com',
          ),
          const SizedBox(height: 20.0),
          teamMember(
            imageUrl: 'assets/images/azura.jpeg',
            name: 'Azura Ridhanti Arasyid',
            role: 'Programmer',
            facebookUrl: 'https://facebook.com',
            twitterUrl: 'https://twitter.com',
            instagramUrl: 'https://instagram.com',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
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
              // Navigate to List
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

  Widget teamMember({
    required String imageUrl,
    required String name,
    required String role,
    required String facebookUrl,
    required String twitterUrl,
    required String instagramUrl,
  }) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0), // Tambahkan jarak dari tepi atas card
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // Membuat sudut gambar tidak lancip
            child: Image.asset(imageUrl, height: 150, width: 150, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          Text(role, style: const TextStyle(fontSize: 14.0)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialMediaIcon(facebookUrl, Icons.facebook),
                const SizedBox(width: 10.0),
                // socialMediaIcon(twitterUrl, Icons.twitter),
                // SizedBox(width: 10.0),
                // socialMediaIcon(instagramUrl, Icons.instagram),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget socialMediaIcon(String url, IconData icon) {
    return InkWell(
      onTap: () {
        // You can use url_launcher package to launch URL
        // launch(url);
      },
      child: Icon(icon, size: 30.0),
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
