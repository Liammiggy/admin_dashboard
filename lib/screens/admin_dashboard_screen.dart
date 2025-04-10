// admin_dashboard_screen.dart
import 'package:admin_dashboard/screens/reports.dart';
import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'dash.dart';
import 'manage_users.dart';
// import 'pastor.dart';
import 'claims.dart';
import 'contributions.dart';
import 'user_list.dart';
import 'user_access_role.dart';
import 'package:admin_dashboard/screens/members/add_member.dart';
import 'package:admin_dashboard/screens/members/member_list.dart';
import 'package:admin_dashboard/screens/members/bulk_upload.dart';
import 'package:admin_dashboard/screens/pastors/pastorList.dart';
import 'package:admin_dashboard/screens/church/church.dart';
import 'package:admin_dashboard/screens/church/addchurch.dart';
import 'package:admin_dashboard/screens/pastors/add_pastor.dart';
import 'package:admin_dashboard/screens/organization/add_organization.dart';
import 'package:admin_dashboard/screens/organization/organization_list.dart';

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
    switch (activePage.trim()) {
      case "Dashboard":
        return Dash();

      // case "user_list": // ✅ Match the route name passed from Sidebar
      //   return UserList();

      case "UserList": // ✅ Match the route name passed from Sidebar
        return UserList();

      case "manage_user":
        return ManageUsers();

      case "access":
        return UserAccess();

      // case "Membership":
      //   return Membership();

      case "memberlist":
        return MemberList();

      case "members":
        return AddMember();

      case "bulkfileupload":
        return browse();

      // case "Pastor":
      //   return Pastor();

      case "pastorlist":
        return PastorList();

      case "churchlist":
        return ChurchList();

      case "add_church":
        return AddnewChurch();

      case "add_pastor":
        return AddPastor();

      case "orglist":
        return PastorList1();

      case "add_org":
        return Add_Organization();

      case "Claims & Request":
        return Claims();

      case "Contributions":
        return Contributions();

      case "Reports":
        return Reports();

      default:
        return Center(
          child: Text(
            "Module not found: $activePage", // ✅ Show actual value
            style: TextStyle(
              color: Color.fromARGB(255, 212, 113, 113),
              fontSize: 24,
            ),
          ),
        );
    }
  }
}

  // Widget _buildPageContent() {
  //   switch (activePage) {
  //     case "Dashboard":
  //       return Dash();
  //     case "Manage Users":
  //       return ManageUsers();
  //     case "Membership":
  //       return Membership();
  //     case "Pastor":
  //       return Pastor();
  //     case "Claims & Request":
  //       return Claims();
  //     case "Contributions":
  //       return Contributions();
  //     case "Reports":
  //       return Reports();
  //     default:
  //       return const Dash();
  //     // Center(
  //     //   child: Text(
  //     //     "Module not founsss",
  //     //     style: TextStyle(
  //     //       color: Color.fromARGB(255, 212, 113, 113),
  //     //       fontSize: 24,
  //     //     ),
  //     //   ),
  //     // );
  //   }
  // }

