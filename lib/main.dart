import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'pages//login/login_page.dart';
import 'pages/dashboard/dashboard_page.dart';
import 'pages/live_data/live_data_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoX',
      initialRoute: AppRoutes.login, // Start with login
      routes: {
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.dashboard: (context) => const DashboardPage(),
        AppRoutes.liveData: (context) => const LiveDataPage(), 
        // AppRoutes.analytics: (context) => const Placeholder(),
        // AppRoutes.alerts: (context) => const Placeholder(),
        // AppRoutes.settings: (context) => const Placeholder(),
      },
    );
  }
}
