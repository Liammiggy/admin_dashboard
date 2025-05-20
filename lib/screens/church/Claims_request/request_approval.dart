import 'package:flutter/material.dart';

class RequestApproval extends StatefulWidget {
  const RequestApproval({super.key});

  @override
  _RequestApprovalState createState() => _RequestApprovalState();
}

class _RequestApprovalState extends State<RequestApproval> {
  final TextEditingController nameController = TextEditingController(
    text: 'Raymond Bolambao',
  );
  final TextEditingController titleController = TextEditingController();
  final TextEditingController pastorController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  String? selectedIncidentType;
  String? selectedContactType;

  final List<Map<String, String>> unpaidContributions = [
    {
      'id': 'ID01',
      'name': 'Raymond Bolambao',
      'title': 'Ramon - Outpatient Minor Surgery',
      'pastor': 'Maternity',
    },
    {
      'id': 'ID02',
      'name': 'Liam Anderson',
      'title': 'Liam - Surgery',
      'pastor': 'Surgery',
    },
    {
      'id': 'ID03',
      'name': 'Mason Clark',
      'title': 'Mason - Death',
      'pastor': 'Death',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1C),
      appBar: AppBar(
        title: const Text(
          'Incident Request Details (for Admin Approval)',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0E0F1C),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Request Form
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1C1E2D),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(nameController, label: 'Name'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          titleController,
                          label: 'Incident Title',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          hint: 'Incident Type',
                          value: selectedIncidentType,
                          items: ['Accident', 'Surgery', 'Death'],
                          onChanged:
                              (value) =>
                                  setState(() => selectedIncidentType = value),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          pastorController,
                          label: 'Pastor',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          hint: 'Phone',
                          value: selectedContactType,
                          items: ['Phone', 'Email'],
                          onChanged:
                              (value) =>
                                  setState(() => selectedContactType = value),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMultilineTextField(
                          reasonController,
                          label: 'If Decline/Disapproved. State your reason.',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Attached Requirements',
                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildImageUploadBox(),
                      const SizedBox(width: 12),
                      _buildImageUploadBox(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildActionButton('Approve', Colors.blue),
                      const SizedBox(width: 8),
                      _buildActionButton('Pending', Colors.red),
                      const SizedBox(width: 8),
                      _buildActionButton('Decline', Colors.grey),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Contributions Table
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1C1E2D),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: '${nameController.text} ',
                      style: const TextStyle(
                        color: Colors.cyanAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      children: const [
                        TextSpan(
                          text: "'s Unpaid Incident Contributions",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width - 32,
                      ),
                      child: DataTable(
                        columnSpacing: 16,
                        columns: const [
                          DataColumn(
                            label: Text(
                              'ID',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Incident Title',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Pastor',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Action',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Status',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                        rows:
                            unpaidContributions.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      item['id']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item['name']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item['title']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item['pastor']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(_buildTextButton('Add Payment')),
                                  const DataCell(
                                    Text(
                                      'Unpaid',
                                      style: TextStyle(color: Colors.red),
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
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildTextField(
    TextEditingController controller, {
    required String label,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(label),
    );
  }

  Widget _buildMultilineTextField(
    TextEditingController controller, {
    required String label,
  }) {
    return TextField(
      controller: controller,
      maxLines: 3,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(label),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      dropdownColor: const Color(0xFF1C1E2D),
      value: value,
      onChanged: onChanged,
      decoration: _inputDecoration(hint),
      style: const TextStyle(color: Colors.white),
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white12),
        borderRadius: BorderRadius.circular(6),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _buildImageUploadBox() {
    return Container(
      height: 100,
      width: 100,
      color: const Color(0xFF2A2D3E),
      child: const Center(
        child: Text('Image File', style: TextStyle(color: Colors.white54)),
      ),
    );
  }

  Widget _buildActionButton(String label, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(
        label,
        style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }

  Widget _buildTextButton(String label) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF576AEB), // Background color
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: const Text(
        'Add Payment',
        style: TextStyle(
          color: Colors.white, // Text color
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
