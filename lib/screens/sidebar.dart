// sidebar.dart
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final Function(String) onSelectModule;
  final bool isSidebarOpen;

  const Sidebar({
    required this.onSelectModule,
    required this.isSidebarOpen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isSidebarOpen ? 250 : 70,
      color: const Color.fromARGB(255, 30, 30, 45),
      child: Column(
        children: [
          IconButton(
            icon: Icon(
              isSidebarOpen ? Icons.menu_open : Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => onSelectModule('toggleSidebar'),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildModule(context, "Dash", Icons.dashboard),
                _buildModule(context, "Manage Users", Icons.person),
                _buildModule(context, "Membership", Icons.group),
                _buildModule(context, "Pastor", Icons.person_pin),
                _buildModule(context, "Claims & Request", Icons.request_page),
                _buildModule(context, "Contributions", Icons.attach_money),
                _buildModule(context, "Reports", Icons.bar_chart),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModule(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title:
          isSidebarOpen
              ? Text(title, style: const TextStyle(color: Colors.white))
              : null,
      onTap: () => onSelectModule(title),
    );
  }
}

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
//   String activeModule = "";
//   bool manageUsersExpanded = false;

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
//                 _buildModule(context, "Dash", Icons.dashboard, "dash"),
//                 _buildExpandableModule("Manage Users", Icons.person, [
//                   _buildSubModule("Manage Users", "manage_users"),
//                   _buildSubModule("New Users", "new_users"),
//                 ]),
//                 _buildModule(context, "Membership", Icons.group, "membership"),
//                 _buildModule(context, "Pastor", Icons.person_pin, "pastor"),
//                 _buildModule(
//                   context,
//                   "Claims & Request",
//                   Icons.request_page,
//                   "claims_requests",
//                 ),
//                 _buildModule(
//                   context,
//                   "Contributions",
//                   Icons.attach_money,
//                   "contributions",
//                 ),
//                 _buildModule(context, "Reports", Icons.bar_chart, "reports"),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildModule(
//     BuildContext context,
//     String title,
//     IconData icon,
//     String route,
//   ) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => activeModule = route),
//       onExit: (_) => setState(() => activeModule = ""),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.white70),
//         title:
//             widget.isSidebarOpen
//                 ? Text(title, style: const TextStyle(color: Colors.white))
//                 : null,
//         tileColor:
//             activeModule == route
//                 ? Colors.blueGrey
//                 : (activeModule == "" && route == activeModule
//                     ? Colors.blue
//                     : Colors.transparent),
//         onTap: () {
//           setState(() => activeModule = route);
//           widget.onSelectModule(route);
//         },
//       ),
//     );
//   }

//   Widget _buildExpandableModule(
//     String title,
//     IconData icon,
//     List<Widget> children,
//   ) {
//     return Column(
//       children: [
//         ListTile(
//           leading: Icon(icon, color: Colors.white70),
//           title:
//               widget.isSidebarOpen
//                   ? Text(title, style: const TextStyle(color: Colors.white))
//                   : null,
//           trailing:
//               widget.isSidebarOpen
//                   ? Icon(
//                     manageUsersExpanded ? Icons.expand_less : Icons.expand_more,
//                     color: Colors.white70,
//                   )
//                   : null,
//           tileColor:
//               activeModule == title ? Colors.blueGrey : Colors.transparent,
//           onTap:
//               () => setState(() => manageUsersExpanded = !manageUsersExpanded),
//         ),
//         if (manageUsersExpanded) ...children,
//       ],
//     );
//   }

//   Widget _buildSubModule(String title, String route) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 40),
//       child: MouseRegion(
//         onEnter: (_) => setState(() => activeModule = route),
//         onExit: (_) => setState(() => activeModule = ""),
//         child: ListTile(
//           title: Text(title, style: const TextStyle(color: Colors.white70)),
//           tileColor:
//               activeModule == route
//                   ? Colors.blueGrey
//                   : (activeModule == "" && route == activeModule
//                       ? Colors.blue
//                       : Colors.transparent),
//           onTap: () {
//             setState(() => activeModule = route);
//             widget.onSelectModule(route);
//           },
//         ),
//       ),
//     );
//   }
// }
