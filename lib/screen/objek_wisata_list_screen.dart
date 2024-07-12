import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_objek_wisata_screen.dart';
import 'tambah_objek_screen.dart';

class ObjekWisataListScreen extends StatefulWidget {
  @override
  _ObjekWisataListScreenState createState() => _ObjekWisataListScreenState();
}

class _ObjekWisataListScreenState extends State<ObjekWisataListScreen> {
  List<dynamic> objekWisataList = [];
  bool _isLoading = false;

  Future<void> _fetchObjekWisata() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token tidak tersedia');
      }

      final response = await http.get(
        Uri.parse('http://10.11.9.25:8080/api/objekwisata'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          objekWisataList = data;
          _isLoading = false;
        });
      } else {
        throw Exception('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan saat mengambil data objek wisata.'),
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteObjekWisata(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token tidak tersedia');
      }

      final response = await http.delete(
        Uri.parse('http://10.11.9.25:8080/api/objekwisata/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _fetchObjekWisata();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Objek Wisata berhasil dihapus')),
        );
      } else {
        throw Exception('Gagal menghapus objek wisata: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan saat menghapus objek wisata.'),
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

  Future<void> _editObjekWisata(Map<String, dynamic> objekWisata) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditObjekWisataScreen(objekWisata: objekWisata),
      ),
    ).then((result) {
      if (result ?? false) {
        _fetchObjekWisata();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchObjekWisata();
  }

  void _refreshList() {
    _fetchObjekWisata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objek Wisata'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahObjekWisataScreen(refreshList: _refreshList),
            ),
          );

          if (result == true) {
            _fetchObjekWisata();
          }
        },
        child: Icon(Icons.add),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : objekWisataList.isEmpty
              ? Center(child: Text('Data objek wisata kosong'))
              : ListView.builder(
                  itemCount: objekWisataList.length,
                  itemBuilder: (context, index) {
                    final objekWisata = objekWisataList[index];
                    return ListTile(
                      title: Text(objekWisata['nama_objek_wisata']),
                      subtitle: Text(objekWisata['kategori']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editObjekWisata(objekWisata);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Hapus Objek Wisata'),
                                  content: Text(
                                      'Apakah Anda yakin ingin menghapus ${objekWisata['nama_objek_wisata']}?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Batal'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Hapus'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _deleteObjekWisata(objekWisata['id']);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
