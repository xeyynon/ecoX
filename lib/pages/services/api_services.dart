import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://your-backend-url.com/api"; // replace with real API

  // Example: Fetch live sensor data
  static Future<Map<String, dynamic>> getLiveData() async {
    final response = await http.get(
      Uri.parse("$baseUrl/live-data"),
      headers: {
        "Authorization": "Bearer YOUR_API_KEY", // if required
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to load live data: ${response.statusCode}");
    }
  }

  // Example: Fetch alerts
  static Future<List<dynamic>> getAlerts() async {
    final response = await http.get(Uri.parse("$baseUrl/alerts"));

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception("Failed to load alerts");
    }
  }

  // Example: Fetch analytics data
  static Future<Map<String, dynamic>> getAnalytics() async {
    final response = await http.get(Uri.parse("$baseUrl/analytics"));

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to load analytics");
    }
  }
}
