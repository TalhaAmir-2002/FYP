import 'package:firebase_database/firebase_database.dart';
class Property {
  final String name;
  final double price;
  final String type; // "rent", "sale", "auction"
  final List<String> images;
  final String uid;


  Property({required this.uid,required this.name, required this.price, required this.type, required this.images});
}
class DataProvider {
  static final DatabaseReference _database = FirebaseDatabase.instance.reference();

  static Future<void> saveProperty(Map<String, dynamic> propertyData) async {
    // Save data to Firebase Realtime Database
    try {
      await _database.child("properties").push().set(propertyData);
    } catch (e) {
      print('Error saving property: $e');
    }
  }
}

