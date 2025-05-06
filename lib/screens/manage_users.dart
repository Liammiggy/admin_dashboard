import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart'; // Import the logger package

final logger = Logger(); // Initialize the logger

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  // String? _selectedGender;
  // final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int? _selectedAccessRole;
  int? _selectedStatus;
  bool _isLoading = false; // Track loading state

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _resetFields() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    // _phoneController.clear();
    _birthDateController.clear();
    // _selectedGender = null;
    // _usernameController.clear();
    _passwordController.clear();
    _selectedAccessRole = null;
    _selectedStatus = null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      bool confirm = await _showConfirmationDialog();
      if (confirm) {
        setState(() {
          _isLoading = true; // Show loader
        });
        final url = Uri.parse('http://stewardshipapi.test/api/manage-users/add');
        try {
          final response = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{ // Changed to dynamic to accommodate integer
              'first_name': _firstNameController.text,
              'last_name': _lastNameController.text,
              'email': _emailController.text,
              // 'phone': _phoneController.text,
              // 'gender': _selectedGender,
              // 'username': _usernameController.text,
              'password': _passwordController.text,
              'birthdate': _birthDateController.text,
              'access_role': _selectedAccessRole, // Now an integer
              'status': _selectedStatus, // New status field as integer
            }),
          );

          logger.d('Save User Response: ${response.statusCode}, ${response.body}');
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
          builder: (context) => AlertDialog(
            title: const Text("Confirm Submission"),
            content: const Text("Are you sure you want to save this user?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Save"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 21, 33, 1),
      appBar: AppBar(
        title: const Text(
          "Add New User",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(21, 21, 33, 1),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 600;

                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isMobile)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // _buildProfileCard(),
                              // const SizedBox(width: 20),
                              Expanded(child: _buildUserForm()),
                            ],
                          )
                        else ...[
                          // _buildProfileCard(),
                          // const SizedBox(height: 20),
                          _buildUserForm(),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(30, 30, 45, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        width: 500,
        height: 300,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(30, 30, 45, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildTextField("Firstname", controller: _firstNameController)),
              const SizedBox(width: 10),
              Expanded(child: _buildTextField("Lastname", controller: _lastNameController)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _buildTextField("Email", controller: _emailController, keyboardType: TextInputType.emailAddress)),
              const SizedBox(width: 10),
              Expanded(child: _buildTextField("Password", controller: _passwordController, isPassword: true)),
            ],
          ),
          _buildDateField("Birthdate", controller: _birthDateController, onTap: () => _selectDate(context)),
          Row(
            children: [
              Expanded(
                  child: _buildDropdownField<int>( // New status dropdown
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
                  )),
              const SizedBox(width: 10),
              Expanded(child: _buildDropdownField<int>( // Updated access role dropdown to integer
                labelText: "Access Role",
                value: _selectedAccessRole,
                items: const [
                  DropdownMenuItem(value: 1, child: Text("Staff", style: TextStyle(color: Colors.white))),
                  DropdownMenuItem(value: 2, child: Text("Pastor", style: TextStyle(color: Colors.white))),
                  DropdownMenuItem(value: 3, child: Text("User", style: TextStyle(color: Colors.white))),
                ],
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedAccessRole = newValue;
                  });
                },
              ),),
            ],
          ),

          const SizedBox(height: 20),
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
                    padding: const EdgeInsets.symmetric(vertical: 24),
                  ),
                  child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _resetFields, // Disable button when loading
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(145, 152, 158, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                  ),
                  child: const Text(
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

  Widget _buildDateField(String label, {TextEditingController? controller, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color.fromRGBO(27, 27, 41, 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white24),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white70),
            onPressed: onTap,
          ),
        ),
        readOnly: true,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label is required";
          }
          // You can add more specific date format validation if needed
          return null;
        },
        onTap: onTap,
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