import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart'; // for validation
import 'package:fyp_frontend/theme/color.dart';
import 'package:image_picker/image_picker.dart';
class AddPropertyScreen extends StatefulWidget {
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _database = FirebaseDatabase.instance.reference();// Example options
  String selectedtype = '';// Firebase reference
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Property data
  String _name = "";
  double _price = 0.0;// Default value (optional)
  String _address = "";
  int _bedrooms = 0;
  int _bathrooms = 0;
  String _description = "";
  List<String> _images = [];
  int minbid=0;
  int time=0;// List to store image URLs

  // Form field controllers (optional, for validation)
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _addressController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bathroomsController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _minbidController = TextEditingController();
  final _openController = TextEditingController();

  Future<String> uploadImageToStorage(imageBytes, String imageName) async {
    final storageRef = FirebaseStorage.instance.ref().child('property_images/$imageName');
    final uploadTask = storageRef.putData(imageBytes);
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  // Functions for image selection (optional)
  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImageFile != null) {
      // Upload the image to Firebase Storage and get the download URL
      final imageBytes = await pickedImageFile.readAsBytes();
      final imageName = pickedImageFile.name; // Use the original filename

      // Implement Firebase Storage logic here (explained below)
      final imageUrl = await uploadImageToStorage(imageBytes, imageName);

      setState(() {
        _images.add(imageUrl); // Add the downloaded URL to the image list
      });
    } else {
      print('Image selection cancelled.');
    }

    // Implement image selection logic using image_picker
  }

  // Function to save property data to Firebase
  Future<void> saveProperty() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final String? currentUserId = _auth.currentUser?.uid;
      // Create a new property object (or map)
      Map<String, dynamic> propertyData = {
        "name": _name,
        "price": _price,
        "type": selectedtype,
        "address": _address,
        "bedrooms": _bedrooms,
        "bathrooms": _bathrooms,
        "description": _description,
        "images": _images,
        "minimum bid": minbid,
        "Time": time,
        "uid":currentUserId// ... image handling logic
      };
      // Save data to Firebase Realtime Database
      await _database.child("properties").push().set(propertyData);

      // Show success message and potentially navigate back
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Property saved successfully!"))
      );
      Timer.periodic(Duration(seconds: 1), (timer){
        Navigator.pop(context);
      }); // Assuming you want to navigate back after save
    }
  }
  @override
  Widget build(BuildContext context) {
  String value='Rent';
    return Scaffold(
        appBar: AppBar(
        title: Text("Add Property"),
          backgroundColor: AppColor.appBgColor,
    ),
    backgroundColor: AppColor.appBgColor,
    body: SingleChildScrollView(
      child: Wrap(
        children: [
          Form(
          key: _formKey,
          child: Column(
          children: [
          // Name field
          TextFormField(
          decoration: InputDecoration(labelText: "Name"),
          validator: RequiredValidator(errorText: "Please enter a name"),
          onSaved: (newValue) => _name = newValue!,
          controller: _nameController,
          ),
      
          // Price field with number keyboard
          TextFormField(
          decoration: InputDecoration(labelText: "Price"),
          keyboardType: TextInputType.number,
          validator: RequiredValidator(errorText: "Please enter a price"),
          onSaved: (newValue) => _price = double.parse(newValue!),
          controller: _priceController,
          ),
          DropdownButtonFormField(
            iconSize: 30,
            dropdownColor: AppColor.cardColor,
            borderRadius: BorderRadius.circular(25),
            value: value,
            icon: Icon(Icons.arrow_drop_down_rounded),
            onChanged: (String? newvalue){
              setState(() {
                value=newvalue!;
                selectedtype=value;
              });
            },
            items: [
              DropdownMenuItem(
                value: 'Rent',
                child: Text('Rent'),
              ),
              DropdownMenuItem(
                value: 'Auction',
                child: Text('Auction'),
              ),
              DropdownMenuItem(
                value: 'Sale',
                child: Text('Sale'),
              )
            ],
          ),
          if(selectedtype=='Auction') Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Min/Starting Bid"),
                validator: RequiredValidator(errorText: "Please enter a bid"),
                onSaved: (newValue) => minbid = int.parse(newValue!),
                controller: _minbidController,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Number of Hours till closed"),
                validator: (value){
                  if(int.parse(value!)<1||int.parse(value!)>48){
                    return("Please Enter between 1 to 48");
                  }else if(value.isEmpty){
                    return("Please Enter a number");
                  }
                },
                onSaved: (newValue) => time = int.parse(newValue!),
                controller: _openController,
              ),
            ],
      
          ),
          TextFormField(
          decoration: InputDecoration(labelText: "Address"),
          validator: RequiredValidator(errorText: "Please enter an address"),
          onSaved: (newValue) => _address = newValue!,
          controller: _addressController,
          ),
      
          // Number of bedrooms field
          TextFormField(
          decoration: InputDecoration(labelText: "Number of Bedrooms"),
          keyboardType: TextInputType.number,
          validator: RequiredValidator(errorText: "Please enter number of bedrooms"),
          onSaved: (newValue) => _bedrooms = int.parse(newValue!),
          controller: _bedroomsController,
          ),
      
          // Number of bathrooms field
          TextFormField(
          decoration: InputDecoration(labelText: "Number of Bathrooms"),
          keyboardType: TextInputType.number,
          validator: RequiredValidator(errorText: "Please enter number of bathrooms"),
            onSaved: (newValue) => _description = newValue!,
            controller: _bathroomsController,
          ),
      
              TextFormField(
              decoration: InputDecoration(labelText: "Description"),
            maxLines: null, // Allow multiline input
            validator: RequiredValidator(errorText: "Please enter a description"),
            onSaved: (newValue) => _description = newValue!,
            controller: _descriptionController,
          ),
            SizedBox(height: 5,),
            // Image selection button (optional)
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(AppColor.cardColor)
              ),
              onPressed: pickImage, // Replace with your image selection logic
              child: Text("Select Images"),
            ),
            _images.isNotEmpty
                ? Row(
              children: _images.map((imageUrl) => Image.network(imageUrl, height: 100)).toList(),
            ):
            SizedBox(height: 5,),
            ElevatedButton(style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.greenAccent)
            ),
              onPressed:saveProperty,
              child: Text("Save Property"),
            ),
          ],
          ),
          ),
        ],
      ),
    ),
    );
  }
}
