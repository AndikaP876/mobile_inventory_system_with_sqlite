import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_inventory_system/screens/add_item_screen.dart';
import 'package:mobile_inventory_system/screens/detail_item_screen.dart'; // Import DetailItemScreen
import '../utils/database_helper.dart';
import '../models/item_model.dart';

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  late Future<List<Item>> _items;

  @override
  void initState() {
    super.initState();
    _items = DatabaseHelper.instance.fetchItems();
  }

  // Fungsi untuk mem-fetch ulang daftar item
  Future<void> _fetchItems() async {
    setState(() {
      _items = DatabaseHelper.instance.fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Barang')),
      body: FutureBuilder<List<Item>>(
        future: _items,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Belum ada barang.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  leading: Image.file(File(item.imagePath)),
                  title: Text(
                    item.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle:
                      Text('Kategori: ${item.category}\nStok: ${item.stock}\nHarga: ${item.price}'),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailItemScreen(item: item),
                      ),
                    );
                    if (result == true) {
                      setState(() {
                        _items = DatabaseHelper.instance
                            .fetchItems(); // Refresh daftar item
                      });
                    }
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemScreen(
                onItemAdded: _fetchItems,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
