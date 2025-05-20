import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: IncidentContributions()));
}

class IncidentContributions extends StatefulWidget {
  const IncidentContributions({super.key});

  @override
  State<IncidentContributions> createState() =>
      _IncidentContributionsPageState();
}

class _IncidentContributionsPageState extends State<IncidentContributions> {
  String? selectedPastor, selectedType, selectedTitle;
  bool showPaymentForm = false;

  // Payment Form
  final _formKey = GlobalKey<FormState>();
  String? savingsType, paymentType, invoice;
  double? amount;

  List<Map<String, dynamic>> contributions = List.generate(10, (index) {
    return {
      'id': 'ID0${index + 1}',
      'name': 'Person ${index + 1}',
      'address': 'Bogo City',
      'amount': 50.0,
      'paid': index % 3 == 0 ? 0.0 : 50.0,
      'pastor': 'Miguel Alvarina',
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d0e1d),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Incident Contributions",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: _dropdownDecoration("Select Pastor"),
                    value: selectedPastor,
                    onChanged:
                        (value) => setState(() => selectedPastor = value),
                    items:
                        ['Miguel Alvarina', 'Pastor B']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: _dropdownDecoration("Incident Type"),
                    value: selectedType,
                    onChanged: (value) => setState(() => selectedType = value),
                    items:
                        ['Medical', 'Fire']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: _dropdownDecoration("Active Incident Title"),
                    value: selectedTitle,
                    onChanged: (value) => setState(() => selectedTitle = value),
                    items:
                        ['Ramon - Outpatient Minor Surgery']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Incident Title and Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Incident Title:\nRamon - Outpatient Minor Surgery",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Total\nPhp 350.00",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Data Table
            Expanded(
              child: ListView(
                children: [
                  DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xff1a1b2e),
                    ),
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
                          'Address',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Amount',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Paid',
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
                        contributions.map((contrib) {
                          bool isPaid = contrib['paid'] == contrib['amount'];
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  contrib['id'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  contrib['name'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  contrib['address'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  contrib['amount'].toStringAsFixed(2),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  contrib['paid'].toStringAsFixed(2),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  contrib['pastor'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              DataCell(
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  onPressed:
                                      () => setState(
                                        () =>
                                            showPaymentForm = !showPaymentForm,
                                      ),
                                  child: const Text("Add Payment"),
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isPaid ? Colors.green : Colors.red,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    isPaid ? "Paid" : "Unpaid",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),

                  // Payment Form Accordion
                  if (showPaymentForm)
                    ExpansionTile(
                      title: const Text(
                        " Incedent Contribution Payment",
                        style: TextStyle(color: Colors.white),
                      ),
                      collapsedBackgroundColor: const Color(0xff1f2937),
                      backgroundColor: const Color(0xff111827),
                      textColor: Colors.white,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: _textInput(
                                          "Incident Title",
                                        ),
                                        onChanged: (val) => invoice = val,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: _textInput("Member Name"),
                                        keyboardType: TextInputType.number,
                                        onChanged:
                                            (val) =>
                                                amount = double.tryParse(val),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: _textInput(
                                          "Incident Contibutions",
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged:
                                            (val) =>
                                                amount = double.tryParse(val),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        decoration: _dropdownDecoration(
                                          "Payment Type",
                                        ),
                                        onChanged:
                                            (val) => setState(
                                              () => paymentType = val,
                                            ),
                                        items:
                                            ['Cash', 'Online']
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(e),
                                                  ),
                                                )
                                                .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: _textInput(
                                          "Invoice / Reference No",
                                        ),
                                        onChanged: (val) => invoice = val,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: _textInput("Amount"),
                                        keyboardType: TextInputType.number,
                                        onChanged:
                                            (val) =>
                                                amount = double.tryParse(val),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    OutlinedButton(
                                      onPressed:
                                          () => setState(
                                            () => showPaymentForm = false,
                                          ),
                                      child: const Text("Reset"),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Insert logic here
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Payment submitted!',
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text("Submit"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: const Color(0xff1f2937),
      border: const OutlineInputBorder(),
    );
  }

  InputDecoration _textInput(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: const Color(0xff1f2937),
      border: const OutlineInputBorder(),
    );
  }
}
