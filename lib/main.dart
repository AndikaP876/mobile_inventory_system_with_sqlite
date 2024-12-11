import 'package:flutter/material.dart';
import 'package:mobile_inventory_system/screens/item_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ItemListScreen()
    );
  }
}
