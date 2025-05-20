// import 'package:flutter/material.dart';

// class UserList extends StatelessWidget {
//   const UserList({super.key}); // Add key to the constructor

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         "User Lista",
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';
// import 'manage_users.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class UserList extends StatefulWidget {
//   const UserList({super.key});

//   @override
//   _UserListState createState() => _UserListState();
// }

// class _UserListState extends State<UserList> {
//   final List<Map<String, dynamic>> users = [
//     {
//       "id": "ID01",
//       "name": "Raymond Bolambao",
//       "username": "Raymond",
//       "role": "Admin",
//       "status": "Active",
//     },
//     {
//       "id": "ID02",
//       "name": "Liam Anderson",
//       "username": "Liam",
//       "role": "Staff",
//       "status": "Inactive",
//     },
//     {
//       "id": "ID03",
//       "name": "Mason Clark",
//       "username": "Mason",
//       "role": "Pastor",
//       "status": "Active",
//     },
//     {
//       "id": "ID04",
//       "name": "Henry Mitchell",
//       "username": "Henry",
//       "role": "Client",
//       "status": "Active",
//     },
//   ];

//   String searchQuery = "";
//   int entriesPerPage = 10; // Default number of entries per page

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(21, 21, 33, 1),
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(21, 21, 33, 1),
//         title: const Text(
//           "User List",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           Padding(
//             // padding: const EdgeInsets.symmetric(horizontal: 10),
//             padding: const EdgeInsets.only(
//               top: 12,
//               right: 15,
//             ), // Added top padding
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromRGBO(67, 94, 190, 1),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 50,
//                   vertical: 20,
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const ManageUsers(),
//                   ), // Navigate to ManageUsers
//                 );
//               },
//               child: const Text(
//                 "Add News",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: const Color.fromRGBO(30, 30, 45, 1),
//                 borderRadius: BorderRadius.circular(10),
//               ),

//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Search Bar
//                   Row(
//                     children: [
//                       Expanded(
//                         child: SizedBox(
//                           width:
//                               MediaQuery.of(context).size.width * 0.5 < 300
//                                   ? 300
//                                   : MediaQuery.of(context).size.width *
//                                       0.5, // Responsive width
//                           child: TextField(
//                             style: const TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               hintText: "Search User...",
//                               hintStyle: const TextStyle(color: Colors.white),
//                               prefixIcon: const Icon(
//                                 Icons.search,
//                                 color: Colors.white,
//                               ),
//                               filled: true,
//                               fillColor: const Color(0xFF0D1117),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                   color: Colors.white24,
//                                 ),
//                               ),
//                             ),
//                             onChanged: (value) {
//                               setState(() {
//                                 searchQuery = value.toLowerCase();
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 16,
//                       ), // Space between search bar and dropdown
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 1,
//                         ),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF0D1117),
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.white24),
//                         ),
//                         child: DropdownButton<int>(
//                           value: entriesPerPage,
//                           dropdownColor: const Color(0xFF0D1117),
//                           style: const TextStyle(color: Colors.white),
//                           iconEnabledColor: Colors.white,
//                           underline: const SizedBox(),
//                           onChanged: (newValue) {
//                             setState(() {
//                               entriesPerPage = newValue!;
//                             });
//                           },
//                           items:
//                               [10, 20, 50, 100].map((value) {
//                                 return DropdownMenuItem<int>(
//                                   value: value,
//                                   child: Text(value.toString()),
//                                 );
//                               }).toList(),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       const Text(
//                         "entries per page",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16), // Space after the Row
//                   // User Table
//                   SizedBox(
//                     width: double.infinity,
//                     child: DataTable(
//                       headingRowColor: WidgetStateColor.resolveWith(
//                         (states) => const Color.fromRGBO(30, 30, 45, 1),
//                       ),
//                       columnSpacing: 16,
//                       columns: const [
//                         DataColumn(
//                           label: Text(
//                             "ID",
//                             style: TextStyle(
//                               color: Color.fromRGBO(67, 94, 190, 1),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         DataColumn(
//                           label: Text(
//                             "Name",
//                             style: TextStyle(
//                               color: Color.fromRGBO(67, 94, 190, 1),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         DataColumn(
//                           label: Text(
//                             "Username",
//                             style: TextStyle(
//                               color: Color.fromRGBO(67, 94, 190, 1),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         DataColumn(
//                           label: Text(
//                             "Access Role",
//                             style: TextStyle(
//                               color: Color.fromRGBO(67, 94, 190, 1),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         DataColumn(
//                           label: Text(
//                             "Action",
//                             style: TextStyle(
//                               color: Color.fromRGBO(67, 94, 190, 1),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         DataColumn(
//                           label: Text(
//                             "Status",
//                             style: TextStyle(
//                               color: Color.fromRGBO(67, 94, 190, 1),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                       rows:
//                           users
//                               .where(
//                                 (user) => user["name"].toLowerCase().contains(
//                                   searchQuery,
//                                 ),
//                               )
//                               .map(
//                                 (user) => DataRow(
//                                   cells: [
//                                     DataCell(
//                                       SelectableText(
//                                         user["id"],
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                     DataCell(
//                                       SelectableText(
//                                         user["name"],
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                     DataCell(
//                                       SelectableText(
//                                         user["username"],
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                     DataCell(
//                                       SelectableText(
//                                         user["role"],
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                     DataCell(
//                                       IconButton(
//                                         icon: const Icon(
//                                           Icons.edit,
//                                           color: Colors.lightBlue,
//                                         ),
//                                         onPressed: () {
//                                           // TODO: Edit functionality
//                                         },
//                                       ),
//                                     ),
//                                     DataCell(
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 10,
//                                           vertical: 4,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color:
//                                               user["status"] == "Active"
//                                                   ? const Color.fromRGBO(
//                                                     21,
//                                                     135,
//                                                     84,
//                                                     1,
//                                                   )
//                                                   : const Color.fromRGBO(
//                                                     220,
//                                                     53,
//                                                     69,
//                                                     1,
//                                                   ),
//                                           borderRadius: BorderRadius.circular(
//                                             5,
//                                           ),
//                                         ),
//                                         child: SelectableText(
//                                           user["status"],
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                               .toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart'; // Import the logger package

final logger = Logger(); // Initialize the logger

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List users = [];
  List filteredUsers = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  // Future<void> fetchUsers() async {
  //   final response = await http.get(
  //     Uri.parse("http://stewardshipapi.test/api/manage-users/list"),
  //   );

  //   logger.d('Fetch Users Response: ${response.statusCode}, ${response.body}');

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     setState(() {
  //       users = List<Map<String, dynamic>>.from(data['users']);
  //       filteredUsers = List<Map<String, dynamic>>.from(users);
  //     });
  //   } else {
  //     // Consider showing an error message to the user
  //     throw Exception('Failed to load users');
  //   }
  // }

  Future<void> fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse("http://stewardshipapi.test/api/manage-users/list"),
      );

      logger.d(
        'Fetch Users Response: ${response.statusCode}, ${response.body}',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          users = List<Map<String, dynamic>>.from(data['users']);
          filteredUsers = List<Map<String, dynamic>>.from(users);
        });
      } else {
        // Consider showing an error message to the user
        throw Exception('Failed to load users');
      }
    } catch (error) {
      // Handle network errors or other exceptions
      logger.e('Error fetching members: $error');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Network error occurred')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void filterSearch(String query) {
    setState(() {
      filteredUsers =
          users
              .where(
                (user) =>
                    user['first_name'].toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    user['last_name'].toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    user['email'].toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  Future<void> _showEditDialog(
    BuildContext context,
    Map<String, dynamic> user,
  ) async {
    TextEditingController firstNameController = TextEditingController(
      text: user['first_name'],
    );
    TextEditingController lastNameController = TextEditingController(
      text: user['last_name'],
    );
    TextEditingController emailController = TextEditingController(
      text: user['email'],
    );
    bool isUpdating = false;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Stack(
              children: [
                AlertDialog(
                  backgroundColor: Colors.grey[800],
                  title: const Text(
                    'Edit User',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        TextField(
                          controller: firstNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                        TextField(
                          controller: lastNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                        TextField(
                          controller: emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                        DropdownButtonFormField<int>(
                          value: user['status'],
                          dropdownColor: Colors.grey[800],
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Status',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text(
                                'Active',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Inactive',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                          onChanged: (int? newValue) {
                            user['status'] = newValue!;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed:
                          isUpdating
                              ? null
                              : () {
                                Navigator.of(context).pop();
                              },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () async {
                        setState(() {
                          isUpdating = true;
                        });

                        try {
                          final response = await http.post(
                            Uri.parse(
                              "http://stewardshipapi.test/api/manage-users/update/${user['user_id']}",
                            ),
                            body: {
                              'first_name': firstNameController.text,
                              'last_name': lastNameController.text,
                              'email': emailController.text,
                              'status': user['status'].toString(),
                            },
                          );

                          logger.d(
                            'Update User Response: ${response.statusCode}, ${response.body}',
                          );

                          setState(() {
                            isUpdating = false;
                          });

                          if (response.statusCode == 200) {
                            final responseData = jsonDecode(response.body);
                            if (responseData['code'] == 200) {
                              // _fetchUsersWithLoading();
                              logger.d('Update User Response: $filteredUsers');
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(responseData['msg'])),
                              );
                              fetchUsers();
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(responseData['msg'])),
                              );
                            }
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to update user'),
                              ),
                            );
                          }
                        } catch (e) {
                          logger.e('Error updating member: $e');
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('An error occurred while updating'),
                            ),
                          );
                        } finally {
                          setState(() {
                            isUpdating = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
                if (isUpdating)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog(
    BuildContext context,
    int userId,
  ) async {
    bool isDeleting = false;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Stack(
              children: [
                AlertDialog(
                  backgroundColor: Colors.grey[800],
                  title: const Text(
                    'Confirm Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          'Are you sure you want to delete this user?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed:
                          isDeleting
                              ? null
                              : () {
                                Navigator.of(context).pop();
                              },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed:
                          isDeleting
                              ? null
                              : () async {
                                setState(() {
                                  isDeleting = true;
                                });
                                final response = await http.delete(
                                  Uri.parse(
                                    "http://stewardshipapi.test/api/manage-users/delete/$userId",
                                  ),
                                );

                                logger.d(
                                  'Delete User Response: ${response.statusCode}, ${response.body}',
                                );

                                setState(() {
                                  isDeleting = false;
                                });

                                if (response.statusCode == 200) {
                                  final responseData = jsonDecode(
                                    response.body,
                                  );
                                  if (responseData['code'] == 200) {
                                    // _fetchUsersWithLoading();
                                    fetchUsers();
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(responseData['msg']),
                                      ),
                                    );
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(responseData['msg']),
                                      ),
                                    );
                                  }
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Failed to connect to the server',
                                      ),
                                    ),
                                  );
                                }
                              },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                if (isDeleting)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme background
      appBar: AppBar(
        title: const Text("User List"),
        backgroundColor: Colors.black,
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      onChanged: filterSearch,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search Member...",
                        hintStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        columnSpacing: 50, // Widen column spacing
                        headingRowColor: WidgetStateColor.resolveWith(
                          (states) => Colors.grey[900]!,
                        ),
                        dataRowColor: WidgetStateColor.resolveWith(
                          (states) => Colors.grey[850]!,
                        ),
                        columns: const [
                          DataColumn(
                            label: Text(
                              "ID",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Name",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Email",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Status",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Action",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                        rows:
                            filteredUsers.map((user) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      "ID${user['user_id']}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${user['first_name']} ${user['last_name']}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      user['email'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            user['status'] == 1
                                                ? Colors.green
                                                : Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        user['status'] == 1
                                            ? "Active"
                                            : "Inactive",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {
                                            _showEditDialog(context, user);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            _showDeleteConfirmationDialog(
                                              context,
                                              user['user_id'],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
