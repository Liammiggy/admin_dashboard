// import 'package:flutter/material.dart';
// import 'screens/login_screen.dart'; // Import the Login Page

// void main() {
//   runApp(const AdminDashboardApp());
// }

// class AdminDashboardApp extends StatelessWidget {
//   const AdminDashboardApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Admin Dashboard',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: LoginScreen(), // Set Login Screen as First Page
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Set login_screen.dart as the first screen
    );
  }
}
