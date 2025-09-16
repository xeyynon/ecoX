class Alert {
  final String id;
  final String deviceId;
  final String deviceName;
  final String message;
  final DateTime timestamp;
  final String severity;

  Alert({
    required this.id,
    required this.deviceId,
    required this.deviceName,
    required this.message,
    required this.timestamp,
    required this.severity,
  });

  factory Alert.fromMap(Map<String, dynamic> data, String id) {
    return Alert(
      id: id,
      deviceId: data['deviceId'],
      deviceName: data['deviceName'],
      message: data['message'],
      timestamp: DateTime.parse(data['timestamp']),
      severity: data['severity'],
    );
  }
}
