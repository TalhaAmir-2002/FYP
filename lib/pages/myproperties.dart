import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fyp_frontend/theme/color.dart';
import 'package:fyp_frontend/utils/myp_data.dart';

import '../utils/data.dart';
import '../widgets/property_item.dart';

class myproperty extends StatefulWidget {
  const myproperty({Key? key});

  @override
  State<myproperty> createState() => _mypropertyState();
}

class _mypropertyState extends State<myproperty> {

  final propertyProvider _propertyProvider = propertyProvider();
  Map? _properties;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    final String? currentUserId = _auth.currentUser?.uid;
    try {
      final properties = await _propertyProvider.fetchPropertiesByUid(currentUserId!);
      setState(() {
        _properties = properties;
      });
    } catch (e) {
      // Handle error
      print('Error loading properties: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property List'),
      ),
      body: _properties == null
          ? Center(child: CircularProgressIndicator(
      ))
          : _buildPropertyList(),
    );
  }
  Widget _buildPropertyList(){
    print(_properties);
    return ListView.builder(
        itemCount: _properties!.length,
        itemBuilder: (context, index) {
          final String propertyId = _properties!.keys.elementAt(index);
          final Map property = _properties![propertyId];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Handle potential image errors
                Image.network(
                  property['images']?.first ?? 'https://placehold.it/100x100',
                  // Placeholder if no image
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.error),
                      ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            property['name'] ?? 'No name available',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColor.green
                            ),
                            child: Center(
                              child: Text(
                                property['type']??"no type",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(property['description'] ??
                          'No description available'),
                      Text(
                        '${property['bedrooms'] ??
                            0} Bedrooms - ${property['bathrooms'] ?? 0} Bathrooms',
                      ),
                      Text(
                        '\Rs ${property['price']?.toStringAsFixed(2) ?? 'N/A'}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
    );
  }
  }
