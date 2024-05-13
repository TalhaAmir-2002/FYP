import 'package:firebase_database/firebase_database.dart';

class propertyProvider {
   final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<Map?> fetchPropertiesByUid(String uid) async {
    try {
      final snapshot = await _database.child('properties').orderByChild('uid').equalTo(uid).get();

      if (snapshot.value != null) {
        return snapshot.value as Map;
      }
      return null;
    } catch (e) {
      print('Error fetching properties: $e');
      return {'':''}; // Return empty list on error
    }
  }

}
