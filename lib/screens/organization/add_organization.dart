import 'package:flutter/material.dart';

class Add_Organization extends StatefulWidget {
  const Add_Organization({super.key});

  @override
  _Add_OrganizationState createState() => _Add_OrganizationState();
}

class _Add_OrganizationState extends State<Add_Organization> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = {
    "Organization Name": TextEditingController(),
    "Owner": TextEditingController(),
    "Type": TextEditingController(),
    "Email": TextEditingController(),
    "Phone": TextEditingController(),
    "Website URL": TextEditingController(),
    "Address": TextEditingController(),
    "City": TextEditingController(),
    "Country": TextEditingController(),
  };

  void _resetFields() {
    for (var controller in _controllers.values) {
      controller.clear();
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      bool confirm = await _showConfirmationDialog();
      if (confirm) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Organization added successfully!")),
        );
        _resetFields();
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
                  "Are you sure you want to save this organization?",
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
          "Add New Organization",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(21, 21, 33, 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField("Organization Name"),

                Row(
                  children: [
                    Expanded(child: _buildTextField("Owner")),
                    SizedBox(width: 10),
                    Expanded(child: _buildTextField("Type")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildTextField("Email")),
                    SizedBox(width: 10),
                    Expanded(child: _buildTextField("Phone")),
                  ],
                ),
                _buildTextField("Website URL"),
                _buildTextField("Address"),
                Row(
                  children: [
                    Expanded(child: _buildTextField("City")),
                    SizedBox(width: 10),
                    Expanded(child: _buildTextField("Country")),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitForm,
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
                        onPressed: _resetFields,
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
    );
  }

  Widget _buildTextField(String label, {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: _controllers[label],
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
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label is required";
          }
          return null;
        },
      ),
    );
  }
}
