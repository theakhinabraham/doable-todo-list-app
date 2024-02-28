import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {

  const Spacing({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.03);
  }
}