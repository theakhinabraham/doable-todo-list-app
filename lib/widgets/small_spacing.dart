import 'package:flutter/material.dart';

class SmallSpacing extends StatelessWidget {

  const SmallSpacing({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.01);
  }
}