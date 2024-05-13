import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DataProvider {
  static final DatabaseReference _database = FirebaseDatabase.instance.reference();

  static Future<List<dynamic>> fetchDataFromDatabase(String s) async {
    try {
      DataSnapshot snapshot = await _database.child(s).get();

      // Check if the data exists
      if (snapshot.value == null) {
        print("Warning: Data at path '$s' is null.");
        return []; // Rex turn an empty list if data is null
      }

      // Decode JSON data (assuming it's a string)
      String jsonData = snapshot.value as String;
      List<dynamic> dataList = jsonDecode(jsonData);

      return dataList;
    } catch (e) {
      print('Error fetching data: $e');
      return []; // Return an empty list on error
    }
  }
}

List<dynamic> populars = [];
List<dynamic> recommended = [];
List<dynamic> recents = [];
List<dynamic> brokers = [];
List<dynamic> companies = [];

Future<void> fetchDataLocally() async {
  populars = await DataProvider.fetchDataFromDatabase('populars');
  recommended =await DataProvider.fetchDataFromDatabase('recommended');
}
var profile = "https://w0.peakpx.com/wallpaper/369/634/HD-wallpaper-jujutsu-kaisen-ryomen-sukuna.jpg";
List categories = [   {     "name" : "All",     "icon" :  FontAwesomeIcons.boxes   },
  {     "name" : "Auction",     "icon" :  FontAwesomeIcons.warehouse   },
  {     "name" : "Rent",     "icon" :  FontAwesomeIcons.moneyBill   },
{     "name" : "Sale",     "icon" :  FontAwesomeIcons.buysellads   }  ];