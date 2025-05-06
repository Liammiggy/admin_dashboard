import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart'; // Import the logger package

final logger = Logger(); // Initialize the logger

class AddnewChurch extends StatefulWidget {
  const AddnewChurch({super.key});

  @override
  _AddnewChurch createState() => _AddnewChurch();
}

class _AddnewChurch extends State<AddnewChurch> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _churchNameController = TextEditingController();
  int? _selectedStatus;
  bool _isLoading = false; // Track loading state

  void _resetFields() {
    _churchNameController.clear();
    _selectedStatus = null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      bool confirm = await _showConfirmationDialog();
      if (confirm) {
        setState(() {
          _isLoading = true; // Show loader
        });
        final url = Uri.parse('http://stewardshipapi.test/api/manage-churches/add');
        try {
          final response = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{ // Changed to dynamic to accommodate integer
              'church_name': _churchNameController.text,
              'status': _selectedStatus, // New status field as integer
            }),
          );

          logger.d('Save Churches Response: ${response.statusCode}, ${response.body}');
          final responseData = jsonDecode(response.body);
          if (response.statusCode == 200) {
            if (responseData['code'] == 200) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(responseData['msg'])),
              );
              _resetFields();
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(responseData['msg'])),
              );
            }
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseData['msg'])),
            );
          }
        } catch (error) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("An error occurred.Please contact your Administrator.")),
          );
        } finally {
          setState(() {
            _isLoading = false; // Hide loader
          });
        }
      }
    }
  }


  Future<bool> _showConfirmationDialog() async {
    return await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text("Confirm Submission"),
                content: Text(
                  "Are you sure you want to save this church?",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("Save"),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 21, 33, 1),
      appBar: AppBar(
        title: const Text(
          "Add New Church",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(21, 21, 33, 1),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField("Church Name", controller: _churchNameController),
                     _buildDropdownField<int>( // New status dropdown
                      labelText: "Status",
                      value: _selectedStatus,
                      items: const [
                        DropdownMenuItem(value: 1, child: Text("Active", style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 0, child: Text("Inactive", style: TextStyle(color: Colors.white))),
                      ],
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedStatus = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitForm, // Disable button when loading
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
                            onPressed: _isLoading ? null : _resetFields, // Disable button when loading
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
                              padding: EdgeInsets.symmetric(vertical: 24),
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
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

    Widget _buildTextField(String label, {TextEditingController? controller, bool isPassword = false, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color.fromRGBO(27, 27, 41, 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white24),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label is required";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField<T>({
    required String labelText,
    T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<T>(
        dropdownColor: const Color.fromRGBO(27, 27, 41, 1),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color.fromRGBO(27, 27, 41, 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white24),
          ),
        ),
        value: value,
        items: items,
        onChanged: onChanged,
        validator: (value) {
          if (value == null) {
            return "$labelText is required";
          }
          return null;
        },
      ),
    );
  }
}