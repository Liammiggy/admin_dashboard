// church.dart
// import 'package:flutter/material.dart';

// class ChurchList extends StatelessWidget {
//   const ChurchList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Church Page List",
//         style: TextStyle(color: Color.fromARGB(255, 54, 1, 1), fontSize: 24),
//       ),
//     );
//   }
// }

import 'package:admin_dashboard/screens/church/addchurch.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart'; // Import the logger package

final logger = Logger(); // Initialize the logger

class ChurchList extends StatefulWidget {
  const ChurchList({super.key});
  @override
  _ChurchListState createState() => _ChurchListState();
}

class _ChurchListState extends State<ChurchList> {
  List churches = [];
  List filteredChurches = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchChurchesWithLoading();
  }

  Future<void> _fetchChurchesWithLoading() async {
    setState(() {
      _isLoading = true;
    });
    await fetchChurches();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> fetchChurches() async {
    final response = await http.get(
      Uri.parse("http://stewardshipapi.test/api/manage-churches/list"),
    );

    logger.d('Fetch Churches Response: ${response.statusCode}, ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        churches = List<Map<String, dynamic>>.from(data['churches']);
        filteredChurches = List<Map<String, dynamic>>.from(churches);
      });
    } else {
      // Consider showing an error message to the user
      throw Exception('Failed to load users');
    }
  }

  void filterSearch(String query) {
    setState(() {
      filteredChurches = churches
          .where((church) =>
              church['church_name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _showEditDialog(BuildContext context, Map<String, dynamic> church) async {
    TextEditingController churchNameController = TextEditingController(text: church['church_name']);
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
                  title: const Text('Edit Church', style: TextStyle(color: Colors.white)),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        TextField(
                          controller: churchNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Church Name',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                          ),
                        ),
                        DropdownButtonFormField<int>(
                          value: church['status'],
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
                            church['status'] = newValue!;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                      onPressed: isUpdating
                          ? null
                          : () {
                              Navigator.of(context).pop();
                            },
                    ),
                    TextButton(
                      child: const Text('Update', style: TextStyle(color: Colors.blue)),
                      onPressed: isUpdating
                          ? null
                          : () async {
                              setState(() {
                                isUpdating = true;
                              });
                              final response = await http.post(
                                Uri.parse("http://stewardshipapi.test/api/manage-churches/update/${church['church_id']}"),
                                body: {
                                  'church_name': churchNameController.text,
                                  'status': church['status'].toString(),
                                },
                              );

                              logger.d('Update Church Response: ${response.statusCode}, ${response.body}');

                              setState(() {
                                isUpdating = false;
                              });

                              if (response.statusCode == 200) {
                                final responseData = jsonDecode(response.body);
                                if (responseData['code'] == 200) {
                                  _fetchChurchesWithLoading();
                                  logger.d('Update Church Response: $filteredChurches');
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
                                  const SnackBar(content: Text('Failed to update church')),
                                );
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

  Future<void> _showDeleteConfirmationDialog(BuildContext context, int churchId) async {
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
                        Text('Are you sure you want to delete this church?', style: TextStyle(color: Colors.white)),
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
                                Uri.parse("http://stewardshipapi.test/api/manage-churches/delete/$churchId"),
                              );

                              logger.d('Delete Church Response: ${response.statusCode}, ${response.body}');

                              setState(() {
                                isDeleting = false;
                              });
                            
                              if (response.statusCode == 200) {
                                final responseData = jsonDecode(response.body);
                                if (responseData['code'] == 200) {
                                  _fetchChurchesWithLoading();
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme background
      appBar: AppBar(
        title: const Text("Church List"),
        backgroundColor: Colors.black,
      ),
      body: _isLoading
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
                      hintText: "Search Church...",
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
                            "Church Name",
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
                      rows: filteredChurches.map((church) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                "ID${church['church_id']}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            DataCell(
                              Text(
                                "${church['church_name']}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  color: church['status'] == 1 ? Colors.green : Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  church['status'] == 1 ? "Active" : "Inactive",
                                  style: const TextStyle(color: Colors.white),
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
                                      _showEditDialog(context, church);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _showDeleteConfirmationDialog(context, church['church_id']);
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
