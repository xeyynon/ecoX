import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_x/models/device.dart';
import 'package:eco_x/models/alert.dart';
import 'api_services.dart';

class FirebaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<List<Device>> getDevices() async {
    final snapshot = await _db.collection('devices').get();
    return snapshot.docs
        .map((doc) => Device.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Future<List<Alert>> getAlerts() async {
    final snapshot = await _db.collection('alerts').get();
    return snapshot.docs
        .map((doc) => Alert.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Stream<List<Device>> listenToDevices() {
    return _db
        .collection('devices')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Device.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  static Stream<List<Alert>> listenToAlerts() {
    return _db
        .collection('alerts')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Alert.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }
}
