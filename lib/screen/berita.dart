import 'package:flutter/material.dart';
import 'package:objek_wisata1/screen/dashboard_screen.dart';
import 'package:objek_wisata1/screen/destinasi_alam.dart';
import 'package:objek_wisata1/screen/galeri.dart';
import 'package:objek_wisata1/screen/login_screen.dart';
import 'package:objek_wisata1/screen/kebudayaan.dart';
import 'package:objek_wisata1/screen/team.dart';


class BeritaScreen extends StatelessWidget {
  const BeritaScreen({super.key}); 

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
            const Text('BERITA'),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3E5FC),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Fetch new data here
        },
        child: ListView.separated(
          padding: const EdgeInsets.all(16.0),
          separatorBuilder: (context, index) => Divider(
            height: 10.0,
            color: Colors.grey[300],
          ),
          itemCount: 2, // Ganti jumlah item berdasarkan data Anda
          itemBuilder: (context, index) {
            return beritaItem(
              imageUrl: 'assets/images/tenggelam.png',
              title: 'Mahasiswa PCR Tenggelam saat Kegiatan Kampus di Objek Wisata Kampar',
              linkText: 'Baca Selengkapnya',
              onTap: () {
                // Action when tapping on "Baca Selengkapnya"
              },
            );
          },
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

  Widget beritaItem({
    required String imageUrl,
    required String title,
    required String linkText,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      elevation: 2.0,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: imageUrl,
                child: Image.asset(imageUrl),
              ),
              const SizedBox(height: 16.0),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                linkText,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
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
                        icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30),
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
                        icon: const Icon(Icons.exit_to_app, color: Colors.white, size: 30),
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
                            // Tambahan handling untuk submenu lainnya bisa ditambahkan di sini
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
