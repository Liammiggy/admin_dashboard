// church.dart
import 'package:flutter/material.dart';

class AddChurchList extends StatelessWidget {
  const AddChurchList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Add church",
        style: TextStyle(color: Color.fromARGB(255, 54, 1, 1), fontSize: 24),
      ),
    );
  }
}
