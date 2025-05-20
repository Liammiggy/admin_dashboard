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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart'; // Import the logger package

final logger = Logger(); // Initialize the logger

class PastorList extends StatefulWidget {
  const PastorList({super.key});
  @override
  _PastorListState createState() => _PastorListState();
}

class _PastorListState extends State<PastorList> {
  List pastors = [];
  List filteredPastors = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPastorsWithLoading();
  }

  Future<void> _fetchPastorsWithLoading() async {
    setState(() {
      _isLoading = true;
    });
    await fetchPastors();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> fetchPastors() async {
    final response = await http.get(
      Uri.parse("http://stewardshipapi.test/api/manage-pastors/list"),
    );

    logger.d(
      'Fetch Pastors Response: ${response.statusCode}, ${response.body}',
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        pastors = List<Map<String, dynamic>>.from(data['pastors']);
        filteredPastors = List<Map<String, dynamic>>.from(pastors);
      });
    } else {
      // Consider showing an error message to the user
      throw Exception('Failed to load users');
    }
  }

  void filterSearch(String query) {
    setState(() {
      filteredPastors =
          pastors
              .where(
                (pastor) =>
                    pastor['first_name'].toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    pastor['last_name'].toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
    });
  }

  Future<void> _showEditDialog(
    BuildContext context,
    Map<String, dynamic> pastor,
  ) async {
    TextEditingController firstNameController = TextEditingController(
      text: pastor['first_name'],
    );
    TextEditingController lastNameController = TextEditingController(
      text: pastor['last_name'],
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
                    'Edit Pastor',
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
                        DropdownButtonFormField<int>(
                          value: pastor['status'],
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
                            pastor['status'] = newValue!;
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
                                    "http://stewardshipapi.test/api/manage-pastors/update/${pastor['pastor_id']}",
                                  ),
                                  body: {
                                    'first_name': firstNameController.text,
                                    'last_name': lastNameController.text,
                                    'status': pastor['status'].toString(),
                                  },
                                );

                                logger.d(
                                  'Update Pastor Response: ${response.statusCode}, ${response.body}',
                                );

                                setState(() {
                                  isUpdating = false;
                                });

                                if (response.statusCode == 200) {
                                  final responseData = jsonDecode(
                                    response.body,
                                  );
                                  if (responseData['code'] == 200) {
                                    _fetchPastorsWithLoading();
                                    logger.d(
                                      'Update Pastor Response: $filteredPastors',
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
                                      content: Text('Failed to update user'),
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
    int pastorId,
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
                          'Are you sure you want to delete this pastor?',
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
                                    "http://stewardshipapi.test/api/manage-pastors/delete/$pastorId",
                                  ),
                                );

                                logger.d(
                                  'Delete Pastor Response: ${response.statusCode}, ${response.body}',
                                );

                                setState(() {
                                  isDeleting = false;
                                });

                                if (response.statusCode == 200) {
                                  final responseData = jsonDecode(
                                    response.body,
                                  );
                                  if (responseData['code'] == 200) {
                                    _fetchPastorsWithLoading();
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
        title: const Text("Pastor List"),
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
                        hintText: "Search Pastor...",
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
                            filteredPastors.map((pastor) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      "ID${pastor['pastor_id']}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${pastor['first_name']} ${pastor['last_name']}",
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
                                            pastor['status'] == 1
                                                ? Colors.green
                                                : Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        pastor['status'] == 1
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
                                            _showEditDialog(context, pastor);
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
                                              pastor['pastor_id'],
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
