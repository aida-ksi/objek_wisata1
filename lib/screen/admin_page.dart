import 'package:flutter/material.dart';
import 'package:objek_wisata1/screen/objek_wisata_list_screen.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ObjekWisataListScreen()),
            );
          },
          child: Text('Objek Wisata'),
        ),
      ),
    );
  }
}
