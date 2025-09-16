class Device {
  final String id;
  final String name;
  final String location;
  final double lat;
  final double lng;
  final String status;
  final double coLevel;
  final DateTime timestamp;
  final List<HistoricalData> historicalData;

  Device({
    required this.id,
    required this.name,
    required this.location,
    required this.lat,
    required this.lng,
    required this.status,
    required this.coLevel,
    required this.timestamp,
    required this.historicalData,
  });

  factory Device.fromMap(Map<String, dynamic> data, String id) {
    return Device(
      id: id,
      name: data['name'],
      location: data['location'],
      lat: data['coords']['lat'],
      lng: data['coords']['lng'],
      status: data['status'],
      coLevel: (data['coLevel'] as num).toDouble(),
      timestamp: DateTime.parse(data['timestamp']),
      historicalData: (data['historicalData'] as List<dynamic>)
          .map((e) => HistoricalData.fromMap(e))
          .toList(),
    );
  }
}

class HistoricalData {
  final double coLevel;
  final DateTime timestamp;

  HistoricalData({required this.coLevel, required this.timestamp});

  factory HistoricalData.fromMap(Map<String, dynamic> data) {
    return HistoricalData(
      coLevel: (data['coLevel'] as num).toDouble(),
      timestamp: DateTime.parse(data['timestamp']),
    );
  }
}
