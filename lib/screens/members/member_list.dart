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

// import 'package:dropdown_button2/dropdown_button2.dart';

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

// import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:admin_dashboard/screens/members/add_member.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart'; // Import the logger package

final logger = Logger(); // Initialize the logger

class MemberList extends StatefulWidget {
  const MemberList({super.key});
  @override
  _MemberListState createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  List members = [];
  List filteredMembers = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse("http://stewardshipapi.test/api/manage-members/list"),
      );

      logger.d('Fetch Members Response: ${response.statusCode}, ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          members = List<Map<String, dynamic>>.from(data['member']);
          filteredMembers = List<Map<String, dynamic>>.from(members);
        });
      } else {
        // Consider showing an error message to the user using a SnackBar or Dialog
        logger.e('Failed to load users: ${response.statusCode}');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load members')),
        );
      }
    } catch (error) {
      // Handle network errors or other exceptions
      logger.e('Error fetching members: $error');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network error occurred')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _showEditDialog(BuildContext context, Map<String, dynamic> member) async {
      TextEditingController firstNameController = TextEditingController(text: member['first_name']);
      TextEditingController lastNameController = TextEditingController(text: member['last_name']);
      TextEditingController emailController = TextEditingController(text: member['email']);
      TextEditingController birthDateController = TextEditingController(text: member['birthdate']);
      TextEditingController parentsNameController = TextEditingController(text: member['parents_name']);
      TextEditingController addressController = TextEditingController(text: member['address']);
      TextEditingController phoneController = TextEditingController(text: member['phone']);
      TextEditingController emailAddressController = TextEditingController(text: member['email']);
      TextEditingController beneficiaryOneController = TextEditingController(text: member['beneficiaries_1']);
      TextEditingController beneficiaryTwoController = TextEditingController(text: member['beneficiaries_2']);
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
                    title: const Text('Edit Member', style: TextStyle(color: Colors.white)),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          TextField(
                            controller: firstNameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                          TextField(
                            controller: lastNameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                          TextField(
                            controller: birthDateController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Birth Date',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                          TextField(
                            controller: parentsNameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Parents Name',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                          TextField(
                            controller: addressController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Address',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                          TextField(
                            controller: phoneController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                          TextField(
                            controller: emailAddressController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                          DropdownButtonFormField<int>(
                            value: member['pastor_id'],
                            dropdownColor: Colors.grey[800],
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Pastor',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 1,
                                child: Text('Pastor 1', style: TextStyle(color: Colors.white)),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text('Pastor 2', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                            onChanged: (int? newValue) {
                              member['pastor_id'] = newValue!;
                            },
                          ),
                          DropdownButtonFormField<int>(
                            value: member['membership_type'],
                            dropdownColor: Colors.grey[800],
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Membership Type',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 1,
                                child: Text('Adult', style: TextStyle(color: Colors.white)),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text('Kids', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                            onChanged: (int? newValue) {
                              member['membership_type'] = newValue!;
                            },
                          ),
                          TextField(
                            controller: beneficiaryOneController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Beneficiary One',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                          TextField(
                            controller: beneficiaryTwoController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Beneficiary Two',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                          DropdownButtonFormField<int>(
                            value: member['status'],
                            dropdownColor: Colors.grey[800],
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Status',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 1,
                                child: Text('Active', style: TextStyle(color: Colors.white)),
                              ),
                              DropdownMenuItem(
                                value: 0,
                                child: Text('Inactive', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                            onChanged: (int? newValue) {
                              member['status'] = newValue!;
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Update', style: TextStyle(color: Colors.blue)),
                        onPressed: () async {
                          setState(() {
                            isUpdating = true;
                          });

                          try {
                            final response = await http.post(
                              Uri.parse("http://stewardshipapi.test/api/manage-members/update/${member['member_id']}"),
                              body: {
                                'first_name': firstNameController.text,
                                'last_name': lastNameController.text,
                                'birthdate': birthDateController.text,
                                'parents_name': parentsNameController.text,
                                'address': addressController.text,
                                'phone': phoneController.text,
                                'email': emailController.text,
                                'pastor_id': member['pastor_id'].toString(),
                                'membership_type': member['membership_type'].toString(),
                                'beneficiaries_1': beneficiaryOneController.text,
                                'beneficiaries_2': beneficiaryTwoController.text,
                                'status': member['status'].toString(),
                              },
                            ).timeout(const Duration(seconds: 10)); // Add a timeout;

                            logger.d('Update Member Response: ${response.statusCode}, ${response.body}');

                            if (response.statusCode == 200) {
                              final responseData = jsonDecode(response.body);
                              if (responseData['code'] == 200) {
                                // Optionally trigger a refresh of the member list
                                // _fetchUsersWithLoading();
                                logger.d('Update User Response: $responseData');
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(responseData['msg'])),
                                );
                                _fetchMembers(); // If you have a direct method to fetch members
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(responseData['msg'])),
                                );
                              }
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Failed to update member')),
                              );
                            }
                          } catch (e) {
                            logger.e('Error updating member: $e');
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('An error occurred while updating')),
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

  
  Future<void> _showDeleteConfirmationDialog(BuildContext context, int memberId) async {
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
                  title: const Text('Confirm Delete', style: TextStyle(color: Colors.white)),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Are you sure you want to delete this member?', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('No', style: TextStyle(color: Colors.white)),
                      onPressed: isDeleting
                          ? null
                          : () {
                              Navigator.of(context).pop();
                            },
                    ),
                    TextButton(
                      child: const Text('Yes', style: TextStyle(color: Colors.red)),
                      onPressed: isDeleting
                          ? null
                          : () async {
                              setState(() {
                                isDeleting = true;
                              });
                              final response = await http.delete(
                                Uri.parse("http://stewardshipapi.test/api/manage-members/delete/$memberId"),
                              );

                              logger.d('Delete Member Response: ${response.statusCode}, ${response.body}');

                              setState(() {
                                isDeleting = false;
                              });
                            
                              if (response.statusCode == 200) {
                                final responseData = jsonDecode(response.body);
                                if (responseData['code'] == 200) {
                                  _fetchMembers();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(responseData['msg'])),
                                  );
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(responseData['msg'])),
                                  );
                                }
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Failed to connect to the server')),
                                );
                              }
                            },
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
  
  void filterSearch(String query) {
    setState(() {
      filteredMembers = members
          .where((member) =>
              member['first_name'].toLowerCase().contains(query.toLowerCase()) ||
              member['last_name'].toLowerCase().contains(query.toLowerCase()) ||
              member['email'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme background
      appBar: AppBar(
        title: const Text("Member List"),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: filterSearch,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search Member...",
                    hintStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
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
                        label: Text("ID", style: TextStyle(color: Colors.white)),
                      ),
                      DataColumn(
                        label: Text(
                          "Name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Birth Date",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Phone",
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
                    rows: filteredMembers.map((member) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "ID${member['member_id']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              "${member['first_name']} ${member['last_name']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              member['birthdate'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              member['phone'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              member['email'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                color: member['status'] == 1 ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                member['status'] == 1 ? "Active" : "Inactive",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.blueGrey,
                                  ),
                                  onPressed: () {
                                    // _showEditDialog(context, member);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    _showEditDialog(context, member);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(context, member['member_id']);
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
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
        ],
      ),
    );
  }
}
