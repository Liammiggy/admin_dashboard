import 'package:flutter/material.dart';

class ReleasingDisbursement extends StatelessWidget {
  const ReleasingDisbursement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111320),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111320),
        elevation: 0,
        title: const Text(
          'Releasing (Disbursement)',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Export PDF'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter row
            Row(
              children: [
                Expanded(child: _buildDarkTextField('Members Name')),
                const SizedBox(width: 16),
                Expanded(child: _buildDarkTextField('Incident Title')),
                const SizedBox(width: 16),
                Expanded(child: _buildDropdownField('Incident Type')),
              ],
            ),
            const SizedBox(height: 20),

            // Main content
            Expanded(
              child: Row(
                children: [
                  // Left panel
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1E2D),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow("Nature of Benefits", "Death"),
                          _infoRow("Name of a Member", "Macario Porones Jr."),
                          _infoRow("Address", "Puerta Princesa City, Palawan"),
                          _infoRow("Spouse", "N/A"),
                          _infoRow("Church", "God's Kingdom Embassy"),
                          _infoRow("Pastor's Name", "Armando Sabado"),
                          _infoRow("Contact No.", "0999 222 22"),
                          _infoRow("Name of Beneficiary", "Cheryl Sabado"),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4A5EF3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "Total Amount active members:   49, 225.00",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _amountRow("For Member", "33, 247.13", "67.50%"),
                          _amountRow("Tithe's Member", "3, 694.13", "7.50%"),
                          _amountRow("Tithes Stewardship", "1,231.38", "2.50%"),
                          _amountRow("Mission Support", "1,231.38", "2.50%"),
                          _amountRow("Stewardship", "9,851.00", "20.00%"),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.wallet,
                                  color: Colors.black,
                                ),
                                label: const Text(
                                  "Disburse Claim",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange[300],
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Right panel placeholder
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1E2D),
                        borderRadius: BorderRadius.circular(8),
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

  Widget _buildDarkTextField(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF1C1E2D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1E2D),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: const Color(0xFF1C1E2D),
          value: null,
          hint: Text(hint, style: const TextStyle(color: Colors.white54)),
          items: const [],
          onChanged: (_) {},
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150, // Fixed width for labels
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountRow(String title, String amount, String percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(title, style: const TextStyle(color: Colors.white70)),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF111320),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(amount, style: const TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              percent,
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
