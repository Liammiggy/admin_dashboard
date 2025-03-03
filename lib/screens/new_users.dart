import 'package:flutter/material.dart';

class NewUsers extends StatelessWidget {
  const NewUsers({super.key}); // Add key to the constructor

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "New Users Pages",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
