// claims.dart
// import 'package:flutter/material.dart';

// class Claims extends StatelessWidget {
//   const Claims({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Claims & Requests Page",
//         style: TextStyle(color: Color.fromARGB(255, 54, 1, 1), fontSize: 24),
//       ),
//     );
//   }
// }
import 'package:admin_dashboard/screens/church/addchurch.dart';
import 'package:admin_dashboard/screens/organization/add_organization.dart';
import 'package:flutter/material.dart';

class Claims extends StatefulWidget {
  const Claims({super.key});
  @override
  _ClaimsState createState() => _ClaimsState();
}

String selectedStatus = 'All';
String selectedDate = 'Newest';
String sortOrder = 'Asc';

class IncidentRequestDialog extends StatelessWidget {
  const IncidentRequestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1B1C36), // Dark theme
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "New Incident Request",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "John Doe",
                filled: true,
                fillColor: Colors.black26,
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Indecent Title",
                filled: true,
                fillColor: Colors.black26,
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Incident Type",
                filled: true,
                fillColor: Colors.black26,
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.black26,
                    ),
                    dropdownColor: Colors.black87,
                    items: const [
                      DropdownMenuItem(
                        value: 'Pastor',
                        child: Text(
                          "Pastor",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.black26,
                    ),
                    dropdownColor: Colors.black87,
                    items: const [
                      DropdownMenuItem(
                        value: 'Status',
                        child: Text(
                          "Status",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Incident Requirements",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              color: Colors.grey[700],
              child: const Center(
                child: Text(
                  "Drag & Drop your files or Browse",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                3,
                (index) =>
                    Container(width: 60, height: 60, color: Colors.white10),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {},
                  child: const Text("Submit"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ClaimsState extends State<Claims> {
  final List<Map<String, dynamic>> users = [
    {
      "id": "ID01",
      "name": "Oasis",
      "incidentTitle": "Cebu City",
      "incidentType": "09123456789",
      "pastor": "Jane Smith",
      "status": "Approved",
    },
    {
      "id": "ID02",
      "name": "Oasis",
      "incidentTitle": "Cebu City",
      "incidentType": "09123456789",
      "pastor": "Jane Smith",
      "status": "Approved",
    },
    {
      "id": "ID03",
      "name": "Oasis",
      "incidentTitle": "Cebu City",
      "incidentType": "09123456789",
      "pastor": "Jane Smith",
      "status": "Pending",
    },
    {
      "id": "ID04",
      "name": "Oasis",
      "incidentTitle": "Cebu City",
      "incidentType": "09123456789",
      "pastor": "Jane Smith",
      "status": "Approved",
    },
    {
      "id": "ID05",
      "name": "Oasis",
      "incidentTitle": "Cebu City",
      "incidentType": "09123456789",
      "pastor": "Jane Smith",
      "status": "Approved",
    },
    {
      "id": "ID06",
      "name": "Oasis",
      "incidentTitle": "Cebu City",
      "incidentType": "09123456789",
      "pastor": "Jane Smith",
      "status": "Approved",
    },
    {
      "id": "ID07",
      "name": "Miguel Alvarina",
      "incidentTitle": "Cebu City",
      "incidentType": "09123456789",
      "pastor": "Jane Smith",
      "status": "Approved",
    },
  ];
  String searchQuery = "";
  int entriesPerPage = 10; // Default number of entries per page
  @override
  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButton<T>(
        value: value,
        dropdownColor: const Color(0xFF0D1117),
        style: const TextStyle(color: Colors.white),
        iconEnabledColor: Colors.white,
        underline: const SizedBox(),
        onChanged: onChanged,
        items:
            items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString()),
              );
            }).toList(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 21, 33, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 21, 33, 1),
        title: const Text(
          "Incident Request Management",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(67, 94, 190, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const IncidentRequestDialog(),
                );
              },
              child: const Text(
                "Add New",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          // Padding(
          //   // padding: const EdgeInsets.symmetric(horizontal: 10),
          //   padding: const EdgeInsets.only(
          //     top: 12,
          //     right: 15,
          //   ), // Added top padding
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: const Color.fromRGBO(67, 94, 190, 1),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(5),
          //       ),
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 50,
          //         vertical: 20,
          //       ),
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const IncidentRequestDialog(),
          //           // const Add_Organization(),
          //         ), // Navigate to ManageUsers
          //       );
          //     },
          //     child: const Text(
          //       "Add New",
          //       style: TextStyle(color: Colors.white, fontSize: 16),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(30, 30, 45, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Row(
                    children: [
                      // Search Bar
                      Expanded(
                        child: SizedBox(
                          width:
                              MediaQuery.of(context).size.width * 0.5 < 300
                                  ? 300
                                  : MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Search Incedent/member...",
                              hintStyle: const TextStyle(color: Colors.white),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: const Color(0xFF0D1117),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.white24,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value.toLowerCase();
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Status Dropdown
                      _buildDropdown<String>(
                        label: 'Status',
                        value: selectedStatus,
                        items: [
                          'All',
                          'Approved',
                          'For Release',
                          'Claimed',
                          'Pending',
                        ],
                        onChanged:
                            (value) => setState(() => selectedStatus = value!),
                      ),
                      const SizedBox(width: 8),

                      // Date Dropdown
                      _buildDropdown<String>(
                        label: 'Date',
                        value: selectedDate,
                        items: ['Newest', 'Oldest'],
                        onChanged:
                            (value) => setState(() => selectedDate = value!),
                      ),
                      const SizedBox(width: 8),

                      // Sort Order Dropdown
                      _buildDropdown<String>(
                        label: 'Sort',
                        value: sortOrder,
                        items: ['Asc', 'Desc'],
                        onChanged:
                            (value) => setState(() => sortOrder = value!),
                      ),
                      const SizedBox(width: 16),

                      // Entries Per Page
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D1117),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: DropdownButton<int>(
                          value: entriesPerPage,
                          dropdownColor: const Color(0xFF0D1117),
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white,
                          underline: const SizedBox(),
                          onChanged: (newValue) {
                            setState(() {
                              entriesPerPage = newValue!;
                            });
                          },
                          items:
                              [10, 20, 50, 100].map((value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "entries per page",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16), // Space after the Row
                  // User Table
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      headingRowColor: WidgetStateColor.resolveWith(
                        (states) => const Color.fromRGBO(30, 30, 45, 1),
                      ),
                      columnSpacing: 16,
                      columns: const [
                        DataColumn(
                          label: Text(
                            "ID",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Name",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Incident Title",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // DataColumn(
                        //   label: Text(
                        //     "Type",
                        //     style: TextStyle(
                        //       color: Color.fromRGBO(67, 94, 190, 1),
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                        DataColumn(
                          label: Text(
                            "Incident Type",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Pastor",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Action",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Status",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows:
                          users
                              .where(
                                (user) => user["name"].toLowerCase().contains(
                                  searchQuery,
                                ),
                              )
                              .map(
                                (user) => DataRow(
                                  cells: [
                                    DataCell(
                                      SelectableText(
                                        user["id"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SelectableText(
                                        user["name"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SelectableText(
                                        user["incidentTitle"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    // DataCell(
                                    //   SelectableText(
                                    //     user["retirementAge"],
                                    //     style: const TextStyle(
                                    //       color: Colors.white,
                                    //     ),
                                    //   ),
                                    // ),
                                    DataCell(
                                      SelectableText(
                                        user["incidentType"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SelectableText(
                                        user["pastor"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),

                                    // DataCell(
                                    //   IconButton(
                                    //     icon: const Icon(
                                    //       Icons.edit,
                                    //       color: Colors.lightBlue,
                                    //     ),
                                    //     onPressed: () {
                                    //       // TODO: Edit functionality
                                    //     },
                                    //   ),
                                    // ),

                                    // DataCell(
                                    //   IconButton(
                                    //     icon: const Icon(
                                    //       Icons.edit,
                                    //       color: Colors.lightBlue,
                                    //     ),
                                    //     onPressed: () {
                                    //       // Navigate to AddNewChurch screen instead of showing a dialog
                                    //       Navigator.of(context).push(
                                    //         MaterialPageRoute(
                                    //           builder:
                                    //               (context) =>
                                    //                   const AddnewChurch(),
                                    //         ),
                                    //       );
                                    //     },
                                    //   ),
                                    // ),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.lightBlue,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (context) =>
                                                    IncidentRequestDialog(),
                                          );
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              user["status"] == "Approved"
                                                  ? const Color.fromRGBO(
                                                    21,
                                                    135,
                                                    84,
                                                    1,
                                                  )
                                                  : const Color.fromRGBO(
                                                    220,
                                                    53,
                                                    69,
                                                    1,
                                                  ),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: SelectableText(
                                          user["status"],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
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
}
