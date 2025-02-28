import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RightPanel extends StatelessWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380, // Ensures consistent width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserProfile(),
          const SizedBox(height: 16),
          _buildRecentActivity(),
          const SizedBox(height: 16),
          _buildRenewal(),
          const SizedBox(height: 16),
          _buildMembershipGrowthChart(),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return SizedBox(
      width: 380,
      child: Card(
        color: Color.fromRGBO(30, 30, 45, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text("Ige Alvarina", style: TextStyle(color: Colors.white)),
          subtitle: Text("Admin", style: TextStyle(color: Colors.white70)),
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return SizedBox(
      width: 380,
      child: Card(
        color: Color.fromRGBO(30, 30, 45, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recent Activity",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              _buildActivityItem("45  ", "New Members Added"),
              _buildActivityItem("12  ", "Claims Submitted Today"),
              _buildActivityItem("15  ", "Pending Indecent Request"),
              _buildActivityItem("10  ", "For Releasing"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRenewal() {
    return SizedBox(
      width: 380,
      child: Card(
        color: Color.fromRGBO(30, 30, 45, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Renewal Reminder (70 Days)",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              _buildActivityItem("March0 3  ", "Juan Dela Cruz"),
              _buildActivityItem("March 20  ", "Andres Bonifacio"),
              _buildActivityItem("March 25  ", "Emilio Aguinaldo"),
              _buildActivityItem("March 27  ", "Tangol Montenegro"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(String count, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$count ",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: description, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipGrowthChart() {
    return SizedBox(
      width: 380,
      child: Card(
        color: Color.fromRGBO(30, 30, 45, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Membership Growth Ratess",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 75),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: Colors.blue,
                        value: 70,
                        title: '70%',
                        radius: 50,
                      ),
                      PieChartSectionData(
                        color: Colors.orange,
                        value: 10,
                        title: '10%',
                        radius: 50,
                      ),
                      PieChartSectionData(
                        color: Colors.cyan,
                        value: 20,
                        title: '20%',
                        radius: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
