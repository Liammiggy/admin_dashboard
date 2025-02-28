// import 'package:flutter/material.dart';

// class Dash extends StatelessWidget {
//   const Dash({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color.fromRGBO(
//         21,
//         21,
//         33,
//         1,
//       ), // Set your desired background color here
//       child: const Center(
//         child: Text(
//           "Dashboard Page",
//           style: TextStyle(
//             color: Color.fromARGB(255, 255, 255, 255),
//             fontSize: 24,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:admin_dashboard/screens/right_panel.dart';

class Dash extends StatelessWidget {
  const Dash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 21, 33, 1), // Dark background
      appBar: AppBar(
        title: const Text(
          "Admin Dashboards",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(21, 21, 33, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildStatsCard("Active", 300, Colors.blue, Icons.person),
                    _buildStatsCard(
                      "In-Active",
                      300,
                      Colors.orange,
                      Icons.person_off,
                    ),
                    _buildStatsCard(
                      "Dropout",
                      2,
                      Colors.purple,
                      Icons.remove_circle,
                    ),
                    _buildStatsCard(
                      "Deceased",
                      2,
                      Colors.red,
                      Icons.person_remove,
                    ),

                    const SizedBox(height: 20),
                    SizedBox(height: 300, child: _buildChart()),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              const Expanded(flex: 1, child: RightPanel()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard(String title, int count, Color color, IconData icon) {
    return Card(
      color: Color.fromRGBO(30, 30, 45, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: Text(
          count.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Monthly Data Overview',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                30,
              ), // Adjust bottom padding
              decoration: BoxDecoration(
                color: const Color.fromRGBO(30, 30, 45, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize:
                                  28, // Increase space for bottom labels
                              getTitlesWidget: (value, meta) {
                                const months = [
                                  'Jan',
                                  'Feb',
                                  'Mar',
                                  'Apr',
                                  'May',
                                  'Jun',
                                  'Jul',
                                  'Aug',
                                  'Sep',
                                  'Oct',
                                  'Nov',
                                  'Dec',
                                ];
                                return SideTitleWidget(
                                  meta: meta,
                                  space: 6, // Extra spacing
                                  child: Transform.rotate(
                                    // Rotate text slightly
                                    angle: 0, // Adjust rotation angle
                                    child: Text(
                                      months[value.toInt()],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            10, // Reduce font size if needed
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        gridData: FlGridData(show: true),
                        barGroups: List.generate(
                          12,
                          (i) => BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: (i + 1) * 10.0,
                                color: Colors.blue,
                                width: 8,
                              ),
                              BarChartRodData(
                                toY: (i + 1) * 7.0,
                                color: Color.fromARGB(255, 25, 228, 255),
                                width: 8,
                              ),
                              BarChartRodData(
                                toY: (i + 1) * 5.0,
                                color: Colors.orange,
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    children: [
                      _buildLegendItem(Colors.blue, "Adult"),
                      _buildLegendItem(
                        Color.fromARGB(255, 25, 228, 255),
                        "Student",
                      ),
                      _buildLegendItem(Colors.orange, "Kids"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
