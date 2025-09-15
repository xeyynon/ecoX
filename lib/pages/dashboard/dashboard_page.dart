import 'package:flutter/material.dart';
import 'package:eco_x/routes/app_routes.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _alertController;
  bool _hasAlert =
      true; // 🚨 mock true for testing (replace with real threshold logic)

  @override
  void initState() {
    super.initState();
    _alertController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _alertController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EcoX"), centerTitle: true),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'EcoX Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text('Live Data'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.liveData);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Analytics'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.analytics);
              },
            ),

            /// 🚨 Animated Alerts entry
            AnimatedBuilder(
              animation: _alertController,
              builder: (context, child) {
                double scale = _hasAlert
                    ? (1 + 0.1 * _alertController.value)
                    : 1.0;
                return Transform.scale(
                  scale: scale,
                  child: ListTile(
                    leading: Icon(
                      Icons.warning,
                      color: _hasAlert ? Colors.red : Colors.orange,
                    ),
                    title: const Text('Alerts'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppRoutes.alerts);
                    },
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.settings);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _DashboardCard(
              title: "Live Data",
              icon: Icons.show_chart,
              color: Colors.green,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.liveData);
              },
            ),
            _DashboardCard(
              title: "Analytics",
              icon: Icons.bar_chart,
              color: Colors.blue,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.analytics);
              },
            ),
            _DashboardCard(
              title: "Alerts",
              icon: Icons.warning,
              color: Colors.red,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.alerts);
              },
            ),
            _DashboardCard(
              title: "Settings",
              icon: Icons.settings,
              color: Colors.orange,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.settings);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
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
            Icon(icon, size: 50, color: color),
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
