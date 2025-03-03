// admin_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'dash.dart';
import 'manage_users.dart';
import 'membership.dart';
import 'pastor.dart';
import 'claims.dart';
import 'contributions.dart';
import 'reports.dart';

void main() {
  runApp(const AdminDashboard());
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const AdminDashboardScreen(),
    );
  }
}

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  String activePage = "Dashboard";
  bool isSidebarOpen = true; // Added missing isSidebarOpen state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            onSelectModule: (String module) {
              setState(() {
                if (module == 'toggleSidebar') {
                  isSidebarOpen = !isSidebarOpen;
                } else {
                  activePage = module;
                }
              });
            },
            isSidebarOpen: isSidebarOpen, // Passes sidebar state
          ),
          Expanded(child: _buildPageContent()),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    switch (activePage) {
      case "Dash":
        return Dash();
      case "Manage Users":
        return ManageUsers();
      case "Membership":
        return Membership();
      case "Pastor":
        return Pastor();
      case "Claims & Request":
        return Claims();
      case "Contributions":
        return Contributions();
      case "Reports":
        return Reports();
      default:
        return const Dash();
      // Center(
      //   child: Text(
      //     "Module not founsss",
      //     style: TextStyle(
      //       color: Color.fromARGB(255, 212, 113, 113),
      //       fontSize: 24,
      //     ),
      //   ),
      // );
    }
  }
}
