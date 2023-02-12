import 'package:flutter/material.dart';

import 'Pages/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Tutorial',
        home: HomePage()
    );
  }
}






