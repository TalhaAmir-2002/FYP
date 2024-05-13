import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final _database = FirebaseDatabase.instance.reference();
class UserData extends ChangeNotifier {
  String name = '';
  String cnic = '';
  String dob = '';
  String contact = '';
  String image = '';

  void updateUser({
    required String name,
    required String cnic,
    required String dob,
    required String contact,
    required String image,
  }) {
    this.name = name;
    this.cnic = cnic;
    this.dob = dob;
    this.contact = contact;
    this.image = image;
    notifyListeners();
  }
}
Future<void> fetchUserData(BuildContext context) async {
  final String? currentUserId = _auth.currentUser?.uid;
  print(currentUserId);

  if (currentUserId != null) {
    // User exists, fetch data
    DataSnapshot dataSnapshot = await _database.child("users").child(currentUserId).get();
    final userData = dataSnapshot.value as Map<dynamic,dynamic>?;

    if (userData != null) {
      // User data found, populate form fields
      Provider.of<UserData>(context, listen: false).updateUser(
        name: userData['Name']?.toString() ?? '',
        cnic: userData['cnic']?.toString() ?? '',
        dob: userData['Dob']?.toString().substring(0, 10) ?? '',
        contact: userData['contact']?.toString() ?? '',
        image: userData['pfp']?.toString() ?? '',
      );
    } else {
      // User data not found (handle non-existent user)
      print("User data not found!");
      // Display message or navigate to create profile screen (not shown)
    }
  }
}