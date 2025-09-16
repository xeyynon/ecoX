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
  bool _hasAlert = false; // will toggle true if threshold exceeded from API

  @override
  void initState() {
    super.initState();
    _alertController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _alertController.dispose();
    super.dispose();
  }

  void _navigate(BuildContext context, String route) {
    Navigator.pop(context); // close drawer
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => Navigator.of(context).widget,
        settings: RouteSettings(name: route),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Simulate alert for now (later link with API)
    if (_hasAlert) {
      _alertController.repeat(reverse: true);
    } else {
      _alertController.stop();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("EcoX Dashboard"), centerTitle: true),
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
              onTap: () => _navigate(context, AppRoutes.liveData),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Analytics'),
              onTap: () => _navigate(context, AppRoutes.analytics),
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text('Alerts'),
              onTap: () => _navigate(context, AppRoutes.alerts),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => _navigate(context, AppRoutes.settings),
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
              onTap: () => Navigator.pushNamed(context, AppRoutes.liveData),
            ),
            _DashboardCard(
              title: "Analytics",
              icon: Icons.bar_chart,
              color: Colors.blue,
              onTap: () => Navigator.pushNamed(context, AppRoutes.analytics),
            ),
            _DashboardCard(
              title: "Alerts",
              icon: Icons.warning,
              color: Colors.red,
              onTap: () => Navigator.pushNamed(context, AppRoutes.alerts),
              hasAlert: _hasAlert,
              controller: _alertController,
            ),
            _DashboardCard(
              title: "Settings",
              icon: Icons.settings,
              color: Colors.orange,
              onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
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
  final bool hasAlert;
  final AnimationController? controller;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    this.hasAlert = false,
    this.controller,
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
            hasAlert && controller != null
                ? AnimatedBuilder(
                    animation: controller!,
                    builder: (context, child) {
                      double scale = 1 + 0.1 * controller!.value;
                      return Transform.scale(
                        scale: scale,
                        child: Icon(icon, size: 50, color: color),
                      );
                    },
                  )
                : Icon(icon, size: 50, color: color),
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
