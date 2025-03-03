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
import 'package:flutter/material.dart';
import 'manage_users.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final List<Map<String, dynamic>> users = [
    {
      "id": "ID01",
      "name": "Raymond Bolambao",
      "username": "Raymond",
      "role": "Admin",
      "status": "Active",
    },
    {
      "id": "ID02",
      "name": "Liam Anderson",
      "username": "Liam",
      "role": "Staff",
      "status": "Inactive",
    },
    {
      "id": "ID03",
      "name": "Mason Clark",
      "username": "Mason",
      "role": "Pastor",
      "status": "Active",
    },
    {
      "id": "ID04",
      "name": "Henry Mitchell",
      "username": "Henry",
      "role": "Client",
      "status": "Active",
    },
  ];

  String searchQuery = "";
  int entriesPerPage = 10; // Default number of entries per page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 21, 33, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 21, 33, 1),
        title: const Text(
          "User List",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            // padding: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.only(
              top: 12,
              right: 15,
            ), // Added top padding
            child: ElevatedButton(
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageUsers(),
                  ), // Navigate to ManageUsers
                );
              },
              child: const Text(
                "Add New",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(30, 30, 45, 1),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width:
                              MediaQuery.of(context).size.width * 0.5 < 300
                                  ? 300
                                  : MediaQuery.of(context).size.width *
                                      0.5, // Responsive width
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Search User...",
                              hintStyle: const TextStyle(color: Colors.white),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: const Color(0xFF0D1117),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.white24,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value.toLowerCase();
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ), // Space between search bar and dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D1117),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: DropdownButton<int>(
                          value: entriesPerPage,
                          dropdownColor: const Color(0xFF0D1117),
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white,
                          underline: const SizedBox(),
                          onChanged: (newValue) {
                            setState(() {
                              entriesPerPage = newValue!;
                            });
                          },
                          items:
                              [10, 20, 50, 100].map((value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "entries per page",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // Space after the Row
                  // User Table
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                        (states) => const Color.fromRGBO(30, 30, 45, 1),
                      ),
                      columnSpacing: 16,
                      columns: const [
                        DataColumn(
                          label: Text(
                            "ID",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Name",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Username",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Access Role",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Action",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Status",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows:
                          users
                              .where(
                                (user) => user["name"].toLowerCase().contains(
                                  searchQuery,
                                ),
                              )
                              .map(
                                (user) => DataRow(
                                  cells: [
                                    DataCell(
                                      SelectableText(
                                        user["id"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SelectableText(
                                        user["name"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SelectableText(
                                        user["username"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SelectableText(
                                        user["role"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.lightBlue,
                                        ),
                                        onPressed: () {
                                          // TODO: Edit functionality
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              user["status"] == "Active"
                                                  ? const Color.fromRGBO(
                                                    21,
                                                    135,
                                                    84,
                                                    1,
                                                  )
                                                  : const Color.fromRGBO(
                                                    220,
                                                    53,
                                                    69,
                                                    1,
                                                  ),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: SelectableText(
                                          user["status"],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
