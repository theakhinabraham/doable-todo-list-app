import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const DoableApp());
}

class DoableApp extends StatelessWidget {
  const DoableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
