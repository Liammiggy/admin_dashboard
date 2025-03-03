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

import 'package:flutter/material.dart';

class UserAccess extends StatefulWidget {
  const UserAccess({super.key});

  @override
  _UserAccessState createState() => _UserAccessState();
}

class _UserAccessState extends State<UserAccess> {
  String selectedRole = 'Administrator';
  final List<String> roles = ['Administrator', 'Editor', 'Viewer'];
  final List<String> modules = ['Module 1', 'Module 2', 'Module 3'];
  final Map<String, Map<String, bool>> permissions = {
    'Module 1': {
      'Create': false,
      'Read': false,
      'Update': false,
      'Delete': false,
    },
    'Module 2': {
      'Create': false,
      'Read': false,
      'Update': false,
      'Delete': false,
    },
    'Module 3': {
      'Create': false,
      'Read': false,
      'Update': false,
      'Delete': false,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('User Access Management'),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Access Management",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              dropdownColor: Colors.grey[900],
              value: selectedRole,
              items:
                  roles.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(
                        role,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value.toString();
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children:
                    modules.map((module) {
                      return Card(
                        color: Colors.grey[850],
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                module,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children:
                                    permissions[module]!.keys.map((permission) {
                                      return Row(
                                        children: [
                                          Checkbox(
                                            value:
                                                permissions[module]![permission],
                                            onChanged: (bool? value) {
                                              setState(() {
                                                permissions[module]![permission] =
                                                    value!;
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          Text(
                                            permission,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  // Handle save action
                },
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
