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
                _buildManageMembers(),
                // _buildModule("Membership", Icons.group),
                // _buildModule("Pastor", Icons.person_pin),
                _buildPastorModule(),
                _buildChurchModule(),
                _buildOrganizationModule(),
                _buildClaimsRequestModule(),
                // _buildModule("Claims & Request", Icons.request_page),
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
      child: Material(
        color:
            Colors
                .transparent, // Ensures no interference with AnimatedContainer
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color:
                _activeModule == title
                    ? const Color.fromRGBO(67, 94, 190, 1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
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
                            _activeModule == title
                                ? const Color.fromARGB(255, 40, 45, 30)
                                : Colors.white,
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
      ),
    );
  }

  Widget _buildManageUsersModule() {
    return Material(
      color:
          _activeModule == "Manage Users"
              ? const Color.fromRGBO(67, 94, 190, 1)
              : Colors.transparent,
      child: ExpansionTile(
        leading: const Icon(Icons.person, color: Colors.white70),
        title:
            widget.isSidebarOpen
                ? const Text(
                  "Manage Users",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
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
      ),
    );
  }

  Widget _buildManageMembers() {
    return Material(
      color:
          _activeModule == "Membership"
              ? const Color.fromRGBO(67, 94, 190, 1)
              : Colors.transparent,
      child: ExpansionTile(
        leading: const Icon(Icons.group_work, color: Colors.white70),
        title:
            widget.isSidebarOpen
                ? const Text(
                  "Membership",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                )
                : const SizedBox.shrink(), // Prevents null error
        initiallyExpanded: _manageUsersExpanded,
        onExpansionChanged:
            (expanded) => setState(() => _manageUsersExpanded = expanded),
        children: [
          _buildSubModule("Member Lists", "memberlist"),
          _buildSubModule("Add Member", "members"),
          _buildSubModule("Bulk Upload", "bulkfileupload"),
        ],
      ),
    );
  }

  Widget _buildPastorModule() {
    return Material(
      color:
          _activeModule == "Pastor"
              ? const Color.fromRGBO(67, 94, 190, 1)
              : Colors.transparent,
      child: ExpansionTile(
        leading: const Icon(Icons.volunteer_activism, color: Colors.white70),
        title:
            widget.isSidebarOpen
                ? const Text(
                  "Pastor",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                )
                : const SizedBox.shrink(), // Prevents null error
        initiallyExpanded: _manageUsersExpanded,
        onExpansionChanged:
            (expanded) => setState(() => _manageUsersExpanded = expanded),
        children: [
          _buildSubModule("Pastor List", "pastorlist"),
          _buildSubModule("New Pastor", "add_pastor"),
          // _buildSubModule("Access Role", "access"),
        ],
      ),
    );
  }

  Widget _buildChurchModule() {
    return Material(
      color:
          _activeModule == "Churchs"
              ? const Color.fromRGBO(67, 94, 190, 1)
              : Colors.transparent,
      child: ExpansionTile(
        leading: const Icon(Icons.church, color: Colors.white70),
        title:
            widget.isSidebarOpen
                ? const Text(
                  "Church",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                )
                : const SizedBox.shrink(), // Prevents null error
        initiallyExpanded: _manageUsersExpanded,
        onExpansionChanged:
            (expanded) => setState(() => _manageUsersExpanded = expanded),
        children: [
          _buildSubModule("Church List", "churchlist"),
          _buildSubModule("New Church", "add_church"),
          // _buildSubModule("Access Role", "access"),
        ],
      ),
    );
  }

  Widget _buildOrganizationModule() {
    return Material(
      color:
          _activeModule == "Organization"
              ? const Color.fromRGBO(67, 94, 190, 1)
              : Colors.transparent,
      child: ExpansionTile(
        leading: const Icon(Icons.account_tree, color: Colors.white70),
        title:
            widget.isSidebarOpen
                ? const Text(
                  "Organization",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                )
                : const SizedBox.shrink(), // Prevents null error
        initiallyExpanded: _manageUsersExpanded,
        onExpansionChanged:
            (expanded) => setState(() => _manageUsersExpanded = expanded),
        children: [
          _buildSubModule("Organization List", "orglist"),
          _buildSubModule("New Organization", "add_org"),
          // _buildSubModule("Access Role", "access"),
        ],
      ),
    );
  }

  Widget _buildClaimsRequestModule() {
    return Material(
      color:
          _activeModule == "ClaimsRequest"
              ? const Color.fromRGBO(67, 94, 190, 1)
              : Colors.transparent,
      child: ExpansionTile(
        leading: const Icon(Icons.request_page, color: Colors.white70),
        title:
            widget.isSidebarOpen
                ? const Text(
                  "Claims & Request",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                )
                : const SizedBox.shrink(), // Prevents null error
        initiallyExpanded: _manageUsersExpanded,
        onExpansionChanged:
            (expanded) => setState(() => _manageUsersExpanded = expanded),
        children: [
          _buildSubModule("Incident Management", "Claims_Request"),
          _buildSubModule("New Request", "add_org"),
          _buildSubModule("Releasing", "orglist"),
          // _buildSubModule("Access Role", "access"),
        ],
      ),
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
      tileColor:
          _activeModule == title
              ? const Color.fromRGBO(67, 94, 190, 1)
              : Colors.transparent,
    );
  }
}

// // option 2

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
//   bool _manageMembersExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       width: widget.isSidebarOpen ? 250 : 80,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade700],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 5)],
//       ),
//       child: Column(
//         children: [
//           _buildHeader(),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 _buildModule("Dashboard", Icons.dashboard),
//                 _buildExpandableModule(
//                   title: "Manage Users",
//                   icon: Icons.person,
//                   isExpanded: _manageUsersExpanded,
//                   onExpand:
//                       (expanded) =>
//                           setState(() => _manageUsersExpanded = expanded),
//                   children: [
//                     _buildSubModule("User List", "UserList"),
//                     _buildSubModule("New User", "manage_user"),
//                     _buildSubModule("Access Role", "access"),
//                   ],
//                 ),
//                 _buildExpandableModule(
//                   title: "Membership",
//                   icon: Icons.group,
//                   isExpanded: _manageMembersExpanded,
//                   onExpand:
//                       (expanded) =>
//                           setState(() => _manageMembersExpanded = expanded),
//                   children: [
//                     _buildSubModule("Member Lists", "memberlist"),
//                     _buildSubModule("Add Member", "members"),
//                   ],
//                 ),
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

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: IconButton(
//           icon: Icon(
//             widget.isSidebarOpen ? Icons.menu_open : Icons.menu,
//             color: Colors.white,
//             size: 30,
//           ),
//           onPressed: () => widget.onSelectModule('toggleSidebar'),
//         ),
//       ),
//     );
//   }

//   Widget _buildModule(String title, IconData icon) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _activeModule = title),
//       onExit: (_) => setState(() => _activeModule = ""),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         decoration: BoxDecoration(
//           color:
//               _activeModule == title ? Colors.blueAccent : Colors.transparent,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: ListTile(
//           leading: Icon(icon, color: Colors.white),
//           title:
//               widget.isSidebarOpen
//                   ? Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight:
//                           _activeModule == title
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                     ),
//                   )
//                   : null,
//           onTap: () {
//             setState(() => _activeModule = title);
//             widget.onSelectModule(title);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildExpandableModule({
//     required String title,
//     required IconData icon,
//     required bool isExpanded,
//     required Function(bool) onExpand,
//     required List<Widget> children,
//   }) {
//     return Material(
//       color: _activeModule == title ? Colors.blueAccent : Colors.transparent,
//       child: Theme(
//         data: ThemeData().copyWith(
//           dividerColor: Colors.transparent,
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//         ),
//         child: ExpansionTile(
//           leading: Icon(icon, color: Colors.white),
//           title:
//               widget.isSidebarOpen
//                   ? Text(title, style: TextStyle(color: Colors.white))
//                   : const SizedBox(),

//           initiallyExpanded: isExpanded,
//           onExpansionChanged: onExpand,
//           children: children,
//         ),
//       ),
//     );
//   }

//   Widget _buildSubModule(String title, String route) {
//     return ListTile(
//       contentPadding: const EdgeInsets.only(left: 40),
//       title: Text(title, style: TextStyle(color: Colors.white70)),
//       onTap: () {
//         setState(() => _activeModule = title);
//         widget.onSelectModule(route);
//       },
//     );
//   }
// }
