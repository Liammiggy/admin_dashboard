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
import 'package:flutter/material.dart';

class ChurchList extends StatefulWidget {
  const ChurchList({super.key});
  @override
  _ChurchListState createState() => _ChurchListState();
}

class _ChurchListState extends State<ChurchList> {
  final List<Map<String, dynamic>> users = [
    {
      "id": "ID01",
      "name": "Raymond Bolambao",
      "address": "Cebu City",
      // "retirementAge": "65",
      "phone": "09123456789",
      "pastor": "Jane Smith",
      "status": "Active",
    },
    {
      "id": "ID02",
      "name": "John Doe",
      "address": "Manila",
      // "retirementAge": "60",
      "phone": "09234567890",
      "pastor": "Raymond Bolambao",
      "status": "Inactive",
    },
    {
      "id": "ID03",
      "name": "Jane Smith",
      "address": "Davao City",
      // "retirementAge": "62",
      "phone": "09345678901",
      "pastor": "John Doe",
      "status": "Active",
    },
    {
      "id": "ID04",
      "name": "Michael Cruz",
      "address": "Quezon City",
      // "retirementAge": "58",
      "phone": "09456789012",
      "pastor": "Jane Smith",
      "status": "Active",
    },
    {
      "id": "ID05",
      "name": "Emily Garcia",
      "address": "Baguio",
      // "retirementAge": "66",
      "phone": "09567890123",
      "pastor": "Michael Cruz",
      "status": "Inactive",
    },
    {
      "id": "ID06",
      "name": "Carlos Mendoza",
      "address": "Iloilo",
      // "retirementAge": "64",
      "phone": "09678901234",
      "pastor": "Emily Garcia",
      "status": "Active",
    },
    {
      "id": "ID07",
      "name": "Anna Lopez",
      "address": "Zamboanga",
      // "retirementAge": "63",
      "phone": "09789012345",
      "pastor": "Carlos Mendoza",
      "status": "Active",
    },
  ];
  String searchQuery = "";
  int entriesPerPage = 10; // Default number of entries per page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 21, 33, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 21, 33, 1),
        title: const Text(
          "Church List",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            // padding: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.only(
              top: 12,
              right: 15,
            ), // Added top padding
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddnewChurch(),
                  ), // Navigate to ManageUsers
                );
              },
              child: const Text(
                "Add Church",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
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
                      Expanded(
                        child: SizedBox(
                          width:
                              MediaQuery.of(context).size.width * 0.5 < 300
                                  ? 300
                                  : MediaQuery.of(context).size.width *
                                      0.5, // Responsive width
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Search Church...",
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
                      const SizedBox(
                        width: 16,
                      ), // Space between search bar and dropdown
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
                            "Church Name",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Address",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // DataColumn(
                        //   label: Text(
                        //     "Retirement Age",
                        //     style: TextStyle(
                        //       color: Color.fromRGBO(67, 94, 190, 1),
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                        DataColumn(
                          label: Text(
                            "Phone",
                            style: TextStyle(
                              color: Color.fromRGBO(67, 94, 190, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Church Pastor",
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
                                        user["address"],
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
                                        user["phone"],
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
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.lightBlue,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  final formKey =
                                                      GlobalKey<FormState>();
                                                  final TextEditingController
                                                  invoiceController =
                                                      TextEditingController();
                                                  final TextEditingController
                                                  amountController =
                                                      TextEditingController();
                                                  String? selectedSavingsType;
                                                  String? selectedPaymentType;
                                                  return Dialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                          30,
                                                          30,
                                                          45,
                                                          1,
                                                        ),
                                                    child: Container(
                                                      width:
                                                          800, // Adjusted width
                                                      height:
                                                          450, // Adjusted height
                                                      padding:
                                                          const EdgeInsets.all(
                                                            20,
                                                          ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          // Title & Close Button
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Savings Payment",
                                                                style: TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              IconButton(
                                                                icon: const Icon(
                                                                  Icons.close,
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                    context,
                                                                  ).pop();
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          // Form
                                                          Form(
                                                            key: formKey,
                                                            child: Column(
                                                              children: [
                                                                // Customer Name (Read-Only)
                                                                TextFormField(
                                                                  readOnly:
                                                                      true,
                                                                  initialValue:
                                                                      "Raymond Bolambao",
                                                                  style: const TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                  decoration: InputDecoration(
                                                                    labelText:
                                                                        "Customer Name",
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            5,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                // Savings Type Dropdown
                                                                Theme(
                                                                  data: Theme.of(
                                                                    context,
                                                                  ).copyWith(
                                                                    canvasColor:
                                                                        const Color.fromRGBO(
                                                                          30,
                                                                          30,
                                                                          45,
                                                                          1,
                                                                        ),
                                                                  ),
                                                                  child: DropdownButtonFormField<
                                                                    String
                                                                  >(
                                                                    decoration: InputDecoration(
                                                                      labelText:
                                                                          "Savings Type",
                                                                      labelStyle:
                                                                          const TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              5,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    dropdownColor:
                                                                        Colors
                                                                            .black87,
                                                                    style: const TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                    items: const [
                                                                      DropdownMenuItem(
                                                                        value:
                                                                            "regular",
                                                                        child: Text(
                                                                          "Regular Savings",
                                                                          style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DropdownMenuItem(
                                                                        value:
                                                                            "deposit",
                                                                        child: Text(
                                                                          "Time Deposit",
                                                                          style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    onChanged: (
                                                                      value,
                                                                    ) {
                                                                      setState(
                                                                        () =>
                                                                            selectedSavingsType =
                                                                                value,
                                                                      );
                                                                    },
                                                                    validator:
                                                                        (
                                                                          value,
                                                                        ) =>
                                                                            value == null
                                                                                ? "Please select a savings type"
                                                                                : null,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                // Payment Type & Invoice Row
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Theme(
                                                                        data: Theme.of(
                                                                          context,
                                                                        ).copyWith(
                                                                          canvasColor:
                                                                              Colors.black87,
                                                                        ),
                                                                        child: DropdownButtonFormField<
                                                                          String
                                                                        >(
                                                                          decoration: InputDecoration(
                                                                            labelText:
                                                                                "Payment Type",
                                                                            labelStyle: const TextStyle(
                                                                              color:
                                                                                  Colors.white,
                                                                            ),
                                                                            enabledBorder: OutlineInputBorder(
                                                                              borderSide: const BorderSide(
                                                                                color:
                                                                                    Colors.white,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(
                                                                                5,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          dropdownColor:
                                                                              Colors.black87,
                                                                          style: const TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          items: const [
                                                                            DropdownMenuItem(
                                                                              value:
                                                                                  "cash",
                                                                              child: Text(
                                                                                "Cash",
                                                                                style: TextStyle(
                                                                                  color:
                                                                                      Colors.white,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DropdownMenuItem(
                                                                              value:
                                                                                  "online",
                                                                              child: Text(
                                                                                "Online",
                                                                                style: TextStyle(
                                                                                  color:
                                                                                      Colors.white,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                          onChanged: (
                                                                            value,
                                                                          ) {
                                                                            setState(
                                                                              () =>
                                                                                  selectedPaymentType =
                                                                                      value,
                                                                            );
                                                                          },
                                                                          validator:
                                                                              (
                                                                                value,
                                                                              ) =>
                                                                                  value ==
                                                                                          null
                                                                                      ? "Please select a payment type"
                                                                                      : null,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Expanded(
                                                                      child: TextFormField(
                                                                        controller:
                                                                            invoiceController,
                                                                        style: const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        decoration: InputDecoration(
                                                                          labelText:
                                                                              "Invoice / Reference Number",
                                                                          labelStyle: const TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          enabledBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                              color:
                                                                                  Colors.white,
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(
                                                                              5,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        validator:
                                                                            (
                                                                              value,
                                                                            ) =>
                                                                                value ==
                                                                                            null ||
                                                                                        value.isEmpty
                                                                                    ? "Required field"
                                                                                    : null,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                // Amount Input
                                                                TextFormField(
                                                                  controller:
                                                                      amountController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  style: const TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                  decoration: InputDecoration(
                                                                    labelText:
                                                                        "Enter Amount...",
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            5,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  validator:
                                                                      (value) =>
                                                                          value == null ||
                                                                                  value.isEmpty
                                                                              ? "Enter a valid amount"
                                                                              : null,
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          const SizedBox(
                                                            height: 20,
                                                          ),

                                                          // Buttons
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    150, // Adjust width
                                                                height:
                                                                    50, // Adjust height
                                                                child: TextButton(
                                                                  style: TextButton.styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .grey,
                                                                    padding: const EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                    ), // Adjust padding
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            8,
                                                                          ), // Rounded corners
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    formKey
                                                                        .currentState
                                                                        ?.reset();
                                                                    invoiceController
                                                                        .clear();
                                                                    amountController
                                                                        .clear();
                                                                    setState(() {
                                                                      selectedSavingsType =
                                                                          null;
                                                                      selectedPaymentType =
                                                                          null;
                                                                    });
                                                                  },
                                                                  child: const Text(
                                                                    "Reset",
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          18, // Match font size with Submit button
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal, // Optional: bold text
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              const SizedBox(
                                                                width: 10,
                                                              ), // Space before the button
                                                              SizedBox(
                                                                width:
                                                                    150, // Adjust width as needed
                                                                height:
                                                                    50, // Adjust height as needed
                                                                child: TextButton(
                                                                  style: TextButton.styleFrom(
                                                                    backgroundColor:
                                                                        const Color.fromRGBO(
                                                                          67,
                                                                          94,
                                                                          190,
                                                                          1,
                                                                        ),
                                                                    padding: const EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                    ), // Padding for better button size
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            5,
                                                                          ), // Optional: rounded corners
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    if (formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      Navigator.of(
                                                                        context,
                                                                      ).pop();
                                                                    }
                                                                  },
                                                                  child: const Text(
                                                                    "Submit",
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          18, // Adjust font size
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal, // Optional: bold text
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
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
                                              user["status"] == "Active"
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
