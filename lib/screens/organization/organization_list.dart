// // pastor.dart
// import 'package:flutter/material.dart';

// class PastorList extends StatelessWidget {
//   const PastorList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Pastor Page List",
//         style: TextStyle(color: Color.fromARGB(255, 54, 1, 1), fontSize: 24),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart'; // Import the logger package

final logger = Logger(); // Initialize the logger

class PastorList1 extends StatefulWidget {
  const PastorList1({super.key});
  @override
  _PastorList1State createState() => _PastorList1State();
}

class _PastorList1State extends State<PastorList1> {
  List orgs = [];
  List filteredOrgs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchOrgsWithLoading();
  }

  Future<void> _fetchOrgsWithLoading() async {
    setState(() {
      _isLoading = true;
    });
    await fetchOrgs();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> fetchOrgs() async {
    final response = await http.get(
      Uri.parse("http://stewardshipapi.test/api/manage-org/list"),
    );

    logger.d('Fetch Orgs Response: ${response.statusCode}, ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        orgs = List<Map<String, dynamic>>.from(data['organization']);
        filteredOrgs = List<Map<String, dynamic>>.from(orgs);
      });
    } else {
      // Consider showing an error message to the user
      throw Exception('Failed to load Orgs');
    }
  }

  void filterSearch(String query) {
    setState(() {
      filteredOrgs =
          orgs
              .where(
                (org) =>
                    org['first_name'].toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    org['last_name'].toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    org['org_name'].toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  Future<void> _showEditDialog(
    BuildContext context,
    Map<String, dynamic> org,
  ) async {
    TextEditingController firstNameController = TextEditingController(
      text: org['first_name'],
    );
    TextEditingController lastNameController = TextEditingController(
      text: org['last_name'],
    );
    TextEditingController orgNameController = TextEditingController(
      text: org['org_name'],
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
                    'Edit Org',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        TextField(
                          controller: orgNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Org Name',
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
                        DropdownButtonFormField<int>(
                          value: org['status'],
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
                            org['status'] = newValue!;
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
                      onPressed:
                          isUpdating
                              ? null
                              : () async {
                                setState(() {
                                  isUpdating = true;
                                });
                                final response = await http.post(
                                  Uri.parse(
                                    "http://stewardshipapi.test/api/manage-org/update/${org['org_id']}",
                                  ),
                                  body: {
                                    'first_name': firstNameController.text,
                                    'last_name': lastNameController.text,
                                    'org_name': orgNameController.text,
                                    'status': org['status'].toString(),
                                  },
                                );

                                logger.d(
                                  'Update User Response: ${response.statusCode}, ${response.body}',
                                );

                                setState(() {
                                  isUpdating = false;
                                });

                                if (response.statusCode == 200) {
                                  final responseData = jsonDecode(
                                    response.body,
                                  );
                                  if (responseData['code'] == 200) {
                                    _fetchOrgsWithLoading();
                                    logger.d(
                                      'Update User Response: $filteredOrgs',
                                    );
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
                                      content: Text('Failed to update org'),
                                    ),
                                  );
                                }
                              },
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.blue),
                      ),
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
    int orgId,
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
                          'Are you sure you want to delete this organization?',
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
                                    "http://stewardshipapi.test/api/manage-org/delete/$orgId",
                                  ),
                                );

                                logger.d(
                                  'Delete Org Response: ${response.statusCode}, ${response.body}',
                                );

                                setState(() {
                                  isDeleting = false;
                                });

                                if (response.statusCode == 200) {
                                  final responseData = jsonDecode(
                                    response.body,
                                  );
                                  if (responseData['code'] == 200) {
                                    _fetchOrgsWithLoading();
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
        title: const Text("Organization List"),
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
                        hintText: "Search Organization...",
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
                              "Organization Name",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Owner Name",
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
                            filteredOrgs.map((org) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      "ID${org['org_id']}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${org['org_name']}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${org['first_name']} ${org['last_name']}",
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
                                            org['status'] == 1
                                                ? Colors.green
                                                : Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        org['status'] == 1
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
                                            _showEditDialog(context, org);
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
                                              org['org_id'],
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
