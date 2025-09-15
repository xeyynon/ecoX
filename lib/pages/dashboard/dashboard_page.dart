import 'package:flutter/material.dart';
import 'package:eco_x/routes/app_routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.teal,
        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(
              context,
              icon: Icons.account_circle,
              title: "Profile",
              color: Colors.blue,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile clicked")),
                );
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.bar_chart,
              title: "Analytics",
              color: Colors.orange,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Analytics clicked")),
                );
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.settings,
              title: "Settings",
              color: Colors.green,
              onTap: () {},
            ),
            _buildDashboardCard(
              context,
              icon: Icons.logout,
              title: "Logout",
              color: Colors.red,
              onTap: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.show_chart,
              title: "Live Data",
              color: Colors.green,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.liveData);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 48),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
