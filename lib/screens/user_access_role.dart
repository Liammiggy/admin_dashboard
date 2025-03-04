// import 'package:flutter/material.dart';

// class UserAccess extends StatelessWidget {
//   const UserAccess({super.key}); // Add key to the constructor

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         "User Access Page here",
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class UserAccess extends StatefulWidget {
//   const UserAccess({super.key});

//   @override
//   _UserAccessState createState() => _UserAccessState();
// }

// class _UserAccessState extends State<UserAccess> {
//   final List<Map<String, dynamic>> modules = [
//     {
//       'name': 'Module 1',
//       'create': true,
//       'read': true,
//       'update': true,
//       'delete': false,
//     },
//     {
//       'name': 'Module 2',
//       'create': true,
//       'read': true,
//       'update': true,
//       'delete': false,
//     },
//     {
//       'name': 'Module 3',
//       'create': true,
//       'read': true,
//       'update': true,
//       'delete': false,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black87,
//       appBar: AppBar(
//         title: const Text("Access Management"),
//         backgroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Access Roles Container
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[850],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Access Roles",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.grey[900],
//                       hintText: "Add access role",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: const Text("Submit"),
//                       ),
//                       const SizedBox(width: 10),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: const Text("Reset"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Access Management Container
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[850],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Access Management",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   DropdownButtonFormField<String>(
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.grey[900],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     dropdownColor: Colors.grey[900],
//                     style: const TextStyle(color: Colors.white),
//                     value: "Administrator",
//                     items:
//                         ["Administrator", "User", "Guest"].map((role) {
//                           return DropdownMenuItem(
//                             value: role,
//                             child: Text(
//                               role,
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           );
//                         }).toList(),
//                     onChanged: (value) {},
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Table (Maximized Width)
//             Expanded(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   columnSpacing: 30,
//                   columns: const [
//                     DataColumn(
//                       label: Text(
//                         "Module",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "Create",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "Read",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "Update",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "Delete",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                   rows:
//                       modules.map((module) {
//                         return DataRow(
//                           cells: [
//                             DataCell(
//                               Text(
//                                 module['name'],
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                             ),
//                             DataCell(
//                               _buildCheckbox(module, 'create', Colors.blue),
//                             ),
//                             DataCell(
//                               _buildCheckbox(module, 'read', Colors.green),
//                             ),
//                             DataCell(
//                               _buildCheckbox(module, 'update', Colors.amber),
//                             ),
//                             DataCell(
//                               _buildCheckbox(module, 'delete', Colors.red),
//                             ),
//                           ],
//                         );
//                       }).toList(),
//                 ),
//               ),
//             ),

//             // Save Changes Button (Under the Table)
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: const Text("Save Changes"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 12,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckbox(Map<String, dynamic> module, String key, Color color) {
//     return Checkbox(
//       value: module[key],
//       onChanged: (bool? value) {
//         setState(() {
//           module[key] = value;
//         });
//       },
//       activeColor: color,
//     );
//   }
// }

import 'package:flutter/material.dart';

class UserAccess extends StatefulWidget {
  const UserAccess({super.key});

  @override
  _UserAccessState createState() => _UserAccessState();
}

class _UserAccessState extends State<UserAccess> {
  final List<Map<String, dynamic>> modules = [
    {
      'name': 'Dashboard',
      'create': true,
      'read': true,
      'update': true,
      'delete': false,
    },
    {
      'name': 'Manage Useres',
      'create': false,
      'read': true,
      'update': false,
      'delete': true,
    },
    {
      'name': 'Membership',
      'create': true,
      'read': false,
      'update': true,
      'delete': false,
    },
    {
      'name': 'Pastor',
      'create': true,
      'read': false,
      'update': true,
      'delete': false,
    },
    {
      'name': 'Claims & Request',
      'create': true,
      'read': false,
      'update': true,
      'delete': false,
    },
    {
      'name': 'Contributions',
      'create': true,
      'read': false,
      'update': true,
      'delete': false,
    },
    {
      'name': 'Reports',
      'create': true,
      'read': false,
      'update': true,
      'delete': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 33),
      appBar: AppBar(
        title: const Text(
          "Access Roles",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 21, 21, 33),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Access Roles Container
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 30, 30, 45),
                borderRadius: BorderRadius.circular(8),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   "Access Roles",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.normal,
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(21, 21, 33, 1),
                      hintText: "Add access role",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(67, 94, 190, 1),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20,
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 10),

                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(
                            145,
                            152,
                            158,
                            1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20,
                          ),
                        ),

                        child: const Text(
                          "Reset",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Access Management Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 30, 30, 45),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Access Management",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(21, 21, 33, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    dropdownColor: Colors.grey[900],
                    style: const TextStyle(color: Colors.white),
                    value: "Administrator",
                    items:
                        [
                          "Administrator",
                          "Staff",
                          "Pastor",
                          "Member",
                          "User",
                          "IT",
                        ].map((role) {
                          return DropdownMenuItem(
                            value: role,
                            child: Text(
                              role,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Table Container (Maximized Width)
            Expanded(
              child: Container(
                width: double.infinity, // Maximizes table width
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 30, 30, 45),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 220,
                      headingRowColor: WidgetStateColor.resolveWith(
                        (states) => const Color.fromRGBO(30, 30, 45, 1),
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            "Module",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Create",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Read",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows:
                          modules.map((module) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    module['name'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                DataCell(
                                  _buildCheckbox(module, 'create', Colors.blue),
                                ),
                                DataCell(
                                  _buildCheckbox(module, 'read', Colors.green),
                                ),
                                DataCell(
                                  _buildCheckbox(
                                    module,
                                    'update',
                                    Colors.amber,
                                  ),
                                ),
                                DataCell(
                                  _buildCheckbox(module, 'delete', Colors.red),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 1),

            // Save Changes Button (Shorter & Closer to Table)
            SizedBox(height: 20), // Adjust spacing manually
            Align(
              alignment: Alignment.topRight, // Moves button up
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(67, 94, 190, 1),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                ),

                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(Map<String, dynamic> module, String key, Color color) {
    return Checkbox(
      value: module[key],
      onChanged: (bool? value) {
        setState(() {
          module[key] = value;
        });
      },
      activeColor: color,
    );
  }
}
