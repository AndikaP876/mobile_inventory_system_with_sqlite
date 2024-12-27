import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_inventory_system/screens/dashboard_screen.dart';
import 'package:mobile_inventory_system/screens/login_screen.dart';
import 'package:mobile_inventory_system/screens/register_screen.dart';
import 'firebase_options.dart';

void main() async {
  // Pastikan binding sudah diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Halaman awal yang akan ditampilkan
      routes: {
        '/': (context) => LoginScreen(), // Halaman login
        '/register': (context) => RegisterScreen(), // Halaman registrasi
        '/dashboard': (context) => DashboardScreen(
            userId: ModalRoute.of(context)!.settings.arguments
                as String), // Menambahkan userId
      },
    );
  }
}
