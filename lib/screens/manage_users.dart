// // manage_users.dart
// import 'package:flutter/material.dart';

// class ManageUsers extends StatelessWidget {
//   const ManageUsers({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Manage Users Page",
//         style: TextStyle(color: Color.fromARGB(255, 54, 1, 1), fontSize: 24),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ManageUsers extends StatelessWidget {
  const ManageUsers({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 21, 33, 1),
      appBar: AppBar(
        title: const Text(
          "Add New User",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(21, 21, 33, 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 600;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add New User Header
                  // Text(
                  //   "Add New User",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(height: 16),

                  // Layout - Stack on Mobile, Row on Desktop
                  if (!isMobile)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileCard(),
                        SizedBox(width: 20),
                        Expanded(child: _buildUserForm()),
                      ],
                    )
                  else ...[
                    _buildProfileCard(),
                    SizedBox(height: 20),
                    _buildUserForm(),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Center(
      // Centers the container
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(30, 30, 45, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        width: 500,
        height: 300,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centers content vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centers content horizontally
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              "Ige Alvarina",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              "System Administrator",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserForm() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(30, 30, 45, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildTextField("Name"),
          _buildTextField("Email"),
          _buildTextField("Phone"),
          _buildTextField("Birthday mm/dd/yy"),
          _buildTextField("Gender"),

          Row(
            children: [
              Expanded(child: _buildTextField("Username")),
              SizedBox(width: 10),
              Expanded(child: _buildTextField("Password", isPassword: true)),
            ],
          ),

          _buildTextField("Access Role"),
          SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(67, 94, 190, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 24),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(145, 152, 158, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 25),
                  ),

                  child: Text(
                    "Reset",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextField(
        obscureText: isPassword,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color.fromRGBO(27, 27, 41, 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white24),
          ),
        ),
      ),
    );
  }
}
