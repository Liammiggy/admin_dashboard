import 'package:flutter/material.dart';

class ContributionsPosted extends StatefulWidget {
  const ContributionsPosted({super.key});

  @override
  State<ContributionsPosted> createState() => _ContributionsPostedState();
}

class _ContributionsPostedState extends State<ContributionsPosted> {
  String? selectedSavingsType;
  String? selectedPaymentType;
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void resetFields() {
    setState(() {
      selectedSavingsType = null;
      selectedPaymentType = null;
      referenceController.clear();
      amountController.clear();
    });
  }

  void submitPayment() {
    // Implement your saving logic here
    print('Savings: $selectedSavingsType');
    print('Payment Type: $selectedPaymentType');
    print('Reference: ${referenceController.text}');
    print('Amount: ${amountController.text}');
    resetFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111322),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111322),
        elevation: 0,
        title: const Text(
          "Individual Savings & Contributions Posted",
          style: TextStyle(
            color: Color(0xFF99A1DB),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "Raymond Bolambao"),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Raymond Bolambao",
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF1B1D2E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _dropdown("Savings Type", [
                    "College Education",
                    "Emergency Fund",
                    "Retirement",
                  ]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _dropdown("Incident Title", [
                    "Sample 1",
                    "Sample 2",
                    "Sample 3",
                  ]),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _contributionSummary(),
            const SizedBox(height: 30),
            _paymentFormSection(),
          ],
        ),
      ),
    );
  }

  Widget _dropdown(String label, List<String> options) {
    return DropdownButtonFormField<String>(
      dropdownColor: const Color(0xFF1B1D2E),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF1B1D2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
      iconEnabledColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      items:
          options
              .map(
                (option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                ),
              )
              .toList(),
      onChanged: (_) {},
    );
  }

  Widget _contributionSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1D2E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SavingType:",
                    style: TextStyle(color: Color(0xFF99A1DB), fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "College Education",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(color: Color(0xFF99A1DB), fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Php 1,500.00",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(child: _HeaderCell("ID")),
              Expanded(child: _HeaderCell("Date")),
              Expanded(child: _HeaderCell("Amount Paid")),
            ],
          ),
          const Divider(color: Color(0xFF3A3E59)),
          ...List.generate(3, (index) {
            final isEven = index % 2 == 0;
            final bgColor =
                isEven ? const Color(0xFF25273D) : const Color(0xFF1B1D2E);
            final rowData =
                [
                  ["ID01", "Jan-2025", "500.00"],
                  ["ID01", "Feb-2025", "500.00"],
                  ["ID01", "March-2025", "500.00"],
                ][index];

            return Container(
              color: bgColor,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      rowData[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rowData[1],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rowData[2],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _paymentFormSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1D2E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Individual Contributions Payment',
            style: TextStyle(
              color: Color(0xFF99A1DB),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedSavingsType,
            dropdownColor: const Color(0xFF1B1D2E),
            decoration: _inputDecoration("Savings Type"),
            style: const TextStyle(color: Colors.white),
            items:
                ['Regular', 'Time Deposit', 'Emergency Fund']
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
            onChanged: (value) => setState(() => selectedSavingsType = value),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedPaymentType,
            dropdownColor: const Color(0xFF1B1D2E),
            decoration: _inputDecoration("Payment Type"),
            style: const TextStyle(color: Colors.white),
            items:
                ['Cash', 'Bank Transfer', 'GCash']
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
            onChanged: (value) => setState(() => selectedPaymentType = value),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: referenceController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Reference/Invoice Number"),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Enter Amount"),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: submitPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF889CF6),
                ),
                child: const Text("Submit"),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: resetFields,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF889CF6)),
                ),
                child: const Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: const Color(0xFF2C2C54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  const _HeaderCell(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF99A1DB),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
