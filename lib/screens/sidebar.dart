// // sidebar.dart
// import 'package:flutter/material.dart';

// class Sidebar extends StatelessWidget {
//   final Function(String) onSelectModule;
//   final bool isSidebarOpen;

//   const Sidebar({
//     required this.onSelectModule,
//     required this.isSidebarOpen,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: isSidebarOpen ? 250 : 70,
//       color: const Color.fromARGB(255, 30, 30, 45),
//       child: Column(
//         children: [
//           IconButton(
//             icon: Icon(
//               isSidebarOpen ? Icons.menu_open : Icons.menu,
//               color: Colors.white,
//             ),
//             onPressed: () => onSelectModule('toggleSidebar'),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 _buildModule(context, "Dashboard", Icons.dashboard),
//                 _buildModule(context, "Manage Users", Icons.person),
//                 _buildModule(context, "User List", Icons.person),
//                 _buildModule(context, "New User", Icons.person),
//                 _buildModule(context, "Membership", Icons.group),
//                 _buildModule(context, "Pastor", Icons.person_pin),
//                 _buildModule(context, "Claims & Request", Icons.request_page),
//                 _buildModule(context, "Contributions", Icons.attach_money),
//                 _buildModule(context, "Reports", Icons.bar_chart),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildModule(BuildContext context, String title, IconData icon) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.white70),
//       title:
//           isSidebarOpen
//               ? Text(title, style: const TextStyle(color: Colors.white))
//               : null,
//       onTap: () => onSelectModule(title),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class Sidebar extends StatefulWidget {
//   final Function(String) onSelectModule;
//   final bool isSidebarOpen;

//   const Sidebar({
//     required this.onSelectModule,
//     required this.isSidebarOpen,
//     super.key,
//   });

//   @override
//   _SidebarState createState() => _SidebarState();
// }

// class _SidebarState extends State<Sidebar> {
//   String _activeModule = "Dashboard";
//   bool _manageUsersExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.isSidebarOpen ? 250 : 70,
//       color: const Color.fromARGB(255, 30, 30, 45),
//       child: Column(
//         children: [
//           IconButton(
//             icon: Icon(
//               widget.isSidebarOpen ? Icons.menu_open : Icons.menu,
//               color: Colors.white,
//             ),
//             onPressed: () => widget.onSelectModule('toggleSidebar'),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 _buildModule("Dashboard", Icons.dashboard),
//                 _buildManageUsersModule(),
//                 _buildModule("Membership", Icons.group),
//                 _buildModule("Pastor", Icons.person_pin),
//                 _buildModule("Claims & Request", Icons.request_page),
//                 _buildModule("Contributions", Icons.attach_money),
//                 _buildModule("Reports", Icons.bar_chart),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildModule(String title, IconData icon) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _activeModule = title),
//       onExit: (_) => setState(() => _activeModule = ""),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.white70),
//         title:
//             widget.isSidebarOpen
//                 ? Text(
//                   title,
//                   style: TextStyle(
//                     color: _activeModule == title ? Colors.blue : Colors.white,
//                     fontWeight:
//                         _activeModule == title
//                             ? FontWeight.bold
//                             : FontWeight.normal,
//                   ),
//                 )
//                 : null,
//         onTap: () {
//           setState(() => _activeModule = title);
//           widget.onSelectModule(title);
//         },
//         tileColor:
//             _activeModule == title ? Colors.blueGrey : Colors.transparent,
//       ),
//     );
//   }

//   Widget _buildManageUsersModule() {
//     return ExpansionTile(
//       leading: Icon(Icons.person, color: Colors.white70),
//       title:
//           widget.isSidebarOpen
//               ? Text(
//                 "Manage Users",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               )
//               : SizedBox.shrink(),
//       initiallyExpanded: _manageUsersExpanded,
//       onExpansionChanged:
//           (expanded) => setState(() => _manageUsersExpanded = expanded),
//       children: [
//         _buildSubModule("User List", "UserList"),
//         _buildSubModule("New User", "manage_user"),
//         _buildSubModule("Access Role", "access"),
//       ],
//     );
//   }

//   Widget _buildSubModule(String title, String route) {
//     return ListTile(
//       contentPadding: EdgeInsets.only(left: 50),
//       title: Text(title, style: TextStyle(color: Colors.white70)),
//       onTap: () {
//         setState(() => _activeModule = title);
//         widget.onSelectModule(route); // Pass the route to the parent widget
//       },
//       tileColor: _activeModule == title ? Colors.blueGrey : Colors.transparent,
//     );
//   }
// }
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final Function(String) onSelectModule;
  final bool isSidebarOpen;

  const Sidebar({
    required this.onSelectModule,
    required this.isSidebarOpen,
    super.key,
  });

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String _activeModule = "Dashboard";
  bool _manageUsersExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: widget.isSidebarOpen ? 250 : 70,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 30, 45),
        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                widget.isSidebarOpen ? Icons.menu_open : Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => widget.onSelectModule('toggleSidebar'),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildModule("Dashboard", Icons.dashboard),
                _buildManageUsersModule(),
                _buildModule("Membership", Icons.group),
                _buildModule("Pastor", Icons.person_pin),
                _buildModule("Claims & Request", Icons.request_page),
                _buildModule("Contributions", Icons.attach_money),
                _buildModule("Reports", Icons.bar_chart),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModule(String title, IconData icon) {
    return MouseRegion(
      onEnter: (_) => setState(() => _activeModule = title),
      onExit: (_) => setState(() => _activeModule = ""),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _activeModule == title ? Colors.blueGrey : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListTile(
          leading: Icon(icon, color: Colors.white70),
          title:
              widget.isSidebarOpen
                  ? Text(
                    title,
                    style: TextStyle(
                      color:
                          _activeModule == title ? Colors.blue : Colors.white,
                      fontWeight:
                          _activeModule == title
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  )
                  : const SizedBox.shrink(), // Prevents null error
          onTap: () {
            setState(() => _activeModule = title);
            widget.onSelectModule(title);
          },
        ),
      ),
    );
  }

  Widget _buildManageUsersModule() {
    return ExpansionTile(
      leading: const Icon(Icons.person, color: Colors.white70),
      title:
          widget.isSidebarOpen
              ? const Text(
                "Manage Users",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
              : const SizedBox.shrink(), // Prevents null error
      initiallyExpanded: _manageUsersExpanded,
      onExpansionChanged:
          (expanded) => setState(() => _manageUsersExpanded = expanded),
      children: [
        _buildSubModule("User List", "UserList"),
        _buildSubModule("New User", "manage_user"),
        _buildSubModule("Access Role", "access"),
      ],
    );
  }

  Widget _buildSubModule(String title, String route) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 50),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      onTap: () {
        setState(() => _activeModule = title);
        widget.onSelectModule(route);
      },
      tileColor: _activeModule == title ? Colors.blueGrey : Colors.transparent,
    );
  }
}
