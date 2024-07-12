import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TambahObjekWisataScreen extends StatefulWidget {
  final Function refreshList; // Function to refresh the list

  TambahObjekWisataScreen({required this.refreshList});

  @override
  _TambahObjekWisataScreenState createState() =>
      _TambahObjekWisataScreenState();
}

class _TambahObjekWisataScreenState extends State<TambahObjekWisataScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _detailController = TextEditingController(); // Controller untuk detail

  bool _isLoading = false;

  Future<void> _tambahObjekWisata() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Mengambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      // Memastikan token tersedia sebelum mengirim permintaan
      if (token == null) {
        throw Exception('Token tidak tersedia');
      }

      // Data objek wisata yang akan ditambahkan
      Map<String, dynamic> newData = {
        'nama_objek_wisata': _namaController.text.trim(),
        'kategori': _kategoriController.text.trim(),
        'alamat': _lokasiController.text.trim(),
        'detail': _detailController.text.trim(),
        'adminId': 1, // Contoh: Menggunakan adminId yang sudah diketahui (sesuaikan dengan aturan aplikasi Anda)
      };

      // Membuat permintaan HTTP untuk menambahkan objek wisata baru
      final response = await http.post(
        Uri.parse('http://10.11.9.25:8080/api/objekwisata'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(newData),
      );

      if (response.statusCode == 200) {
        // Objek wisata berhasil ditambahkan
        Map<String, dynamic> responseData = jsonDecode(response.body);
        // Update newData dengan data yang telah ditambahkan oleh server
        newData.addAll(responseData);

        // Panggil fungsi refreshList untuk memperbarui daftar objek wisata
        widget.refreshList();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Objek Wisata berhasil ditambahkan')),
        );
        Navigator.pop(context, true); // Kembali ke halaman sebelumnya dengan status berhasil
      } else {
        // Log error message from response body
        print('Error: ${response.body}');
        throw Exception('Gagal menambahkan objek wisata: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan saat menambahkan objek wisata.'),
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Objek Wisata'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: _namaController,
                    decoration: InputDecoration(labelText: 'Nama Objek Wisata'),
                  ),
                  SizedBox(height: 12.0),
                  TextField(
                    controller: _kategoriController,
                    decoration: InputDecoration(labelText: 'Kategori'),
                  ),
                  SizedBox(height: 12.0),
                  TextField(
                    controller: _lokasiController,
                    decoration: InputDecoration(labelText: 'Alamat'), // Mengubah 'Lokasi' menjadi 'Alamat'
                  ),
                  SizedBox(height: 12.0),
                  TextField(
                    controller: _detailController,
                    decoration: InputDecoration(labelText: 'Detail'),
                    maxLines: 4, // Boleh disesuaikan dengan kebutuhan
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _tambahObjekWisata,
                    child: Text('Tambah Objek Wisata'),
                  ),
                ],
              ),
            ),
    );
  }
}
