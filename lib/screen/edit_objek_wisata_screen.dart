import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditObjekWisataScreen extends StatefulWidget {
  final Map<String, dynamic> objekWisata;

  const EditObjekWisataScreen({Key? key, required this.objekWisata})
      : super(key: key);

  @override
  _EditObjekWisataScreenState createState() => _EditObjekWisataScreenState();
}

class _EditObjekWisataScreenState extends State<EditObjekWisataScreen> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _kategoriController = TextEditingController();
  TextEditingController _lokasiController = TextEditingController();
  TextEditingController _detailController = TextEditingController(); // Controller untuk detail

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.objekWisata['nama_objek_wisata'];
    _kategoriController.text = widget.objekWisata['kategori'];
    _lokasiController.text = widget.objekWisata['alamat'];
    _detailController.text = widget.objekWisata['detail']; // Set nilai awal detail
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Objek Wisata'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama Objek Wisata'),
            ),
            TextField(
              controller: _kategoriController,
              decoration: InputDecoration(labelText: 'Kategori'),
            ),
            TextField(
              controller: _lokasiController,
              decoration: InputDecoration(labelText: 'Lokasi'),
            ),
            TextField(
              controller: _detailController,
              decoration: InputDecoration(labelText: 'Detail'),
              maxLines: 4, // Boleh disesuaikan dengan kebutuhan
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle fungsi update objek wisata
                _updateObjekWisata(widget.objekWisata['id']);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateObjekWisata(int id) async {
    try {
      // Mengambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      // Memastikan token tersedia sebelum mengirim permintaan
      if (token == null) {
        throw Exception('Token tidak tersedia');
      }

      // Data objek wisata yang diperbarui
      Map<String, dynamic> updatedData = {
        'nama_objek_wisata': _namaController.text.trim(),
        'kategori': _kategoriController.text.trim(),
        'alamat': _lokasiController.text.trim(),
        'detail': _detailController.text.trim(), // Masukkan nilai detail
      };

      // Membuat permintaan HTTP put ke endpoint objek wisata berdasarkan ID
      final response = await http.put(
        Uri.parse('http://10.11.9.25:8080/api/objekwisata/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        // Navigasi kembali ke halaman list setelah update berhasil
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Objek Wisata berhasil diperbarui')),
        );
      } else {
        throw Exception('Gagal memperbarui objek wisata: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan saat memperbarui objek wisata.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
