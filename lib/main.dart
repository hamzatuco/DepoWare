import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:depoware/Pages/LoginScreen.dart';

void main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, title: 'DepoWare', home: Login());
  }
}
