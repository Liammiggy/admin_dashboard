import 'package:flutter/material.dart';

class AddPastor extends StatefulWidget {
  const AddPastor({super.key});

  @override
  _AddPastorState createState() => _AddPastorState();
}

class _AddPastorState extends State<AddPastor> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = {
    "First Name": TextEditingController(),
    "Last Name": TextEditingController(),
    "Parents Name": TextEditingController(),
    "Address": TextEditingController(),
    "Country": TextEditingController(),
    "Phone": TextEditingController(),
    "Email": TextEditingController(),
    "Age": TextEditingController(),
    "Adult": TextEditingController(),
    "Geography": TextEditingController(),
    "Pastor": TextEditingController(),
    "Church": TextEditingController(),
    "Benefeciaries 1": TextEditingController(),
    "Benefeciaries 2": TextEditingController(),
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Member added successfully!")));
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
                content: Text("Are you sure you want to save this member?"),
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
          "Add New Pastor",
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

              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(30, 30, 45, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        width: 500,
        height: 300,
        child: Column(
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
              "Browse Image",
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
          // _buildTextField("First Name"),
          // _buildTextField("Last Name"),
          // _buildTextField("Parents Name"),
          Row(
            children: [
              Expanded(child: _buildTextField("First Name")),
              SizedBox(width: 10),
              Expanded(child: _buildTextField("Last Name")),
            ],
          ),
          Row(
            children: [
              Expanded(child: _buildTextField("Address")),
              SizedBox(width: 10),
              Expanded(child: _buildTextField("Country")),
            ],
          ),
          Row(
            children: [
              Expanded(child: _buildTextField("Phone")),
              SizedBox(width: 10),
              Expanded(child: _buildTextField("Email")),
            ],
          ),

          Row(
            children: [
              Expanded(child: _buildTextField("Birthday")),
              SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Organization-Church",
                    border: OutlineInputBorder(),
                  ),
                  dropdownColor: Colors.black,
                  style: TextStyle(color: Colors.white),
                  items:
                      ["Church 1", "Church 2", "Church 3"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    // Handle change
                  },
                ),
              ),
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
                    backgroundColor: const Color.fromRGBO(145, 152, 158, 1),
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
