import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fyp_frontend/pages/root.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../utils/getuser.dart';

class saveuser extends StatefulWidget {
  saveuser({Key? key});

  @override
  State<saveuser> createState() => _saveuserState();
}

class _saveuserState extends State<saveuser> {
  final _database = FirebaseDatabase.instance.reference();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  late TextEditingController _namecontroller;
  late TextEditingController _cniccontroller;
  late TextEditingController _dobcontroller;
  late TextEditingController _contactcontroller;


  String name = '';
  double cnic = 0;
  DateTime? _selectedDate;
  double contact = 0;
  String image = '';


  void initState() {
    super.initState();
    _namecontroller = TextEditingController();
    _cniccontroller = TextEditingController();
    _dobcontroller = TextEditingController();
    _contactcontroller = TextEditingController();
    // Initialize text controllers with data from UserData provider
    final userData = context.read<UserData>();
    _namecontroller.text = userData.name;
    _cniccontroller.text = userData.cnic;
    _dobcontroller.text = userData.dob;
    _contactcontroller.text = userData.contact;
  }
  @override
  void dispose() {
    // Dispose text controllers
    _namecontroller.dispose();
    _cniccontroller.dispose();
    _dobcontroller.dispose();
    _contactcontroller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobcontroller.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }
  Future<String> uploadImageToStorage(
      imageBytes, String imageName) async {
    // Implement Firebase Storage logic to upload the image
    final storageRef = FirebaseStorage.instance.ref().child('user_images/$imageName');
    final uploadTask = storageRef.putData(imageBytes);
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  Future<void> pickImage() async {
    // Implement image selection logic using image_picker
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImageFile != null) {
      // Upload the image to Firebase Storage and get the download URL
      final imageBytes = await pickedImageFile.readAsBytes();
      final imageName = pickedImageFile.name; // Use the original filename

      // Implement Firebase Storage logic here (explained below)
      final imageUrl = await uploadImageToStorage(imageBytes, imageName);

      setState(() {
        image=imageUrl; // Add the downloaded URL to the image list
      });
    } else {
      print('Image selection cancelled.');
    }

  }


  Future<void> saveUserData() async {
    if (_formKey.currentState!.validate()) {
      final String? currentUserId = _auth.currentUser?.uid;

      _formKey.currentState!.save();
      Map<String, dynamic> userdata = {
        'Name': name,
        'contact': contact,
        'cnic': cnic,
        'Dob': _selectedDate?.toIso8601String(),
        'pfp': image
      };
      if (currentUserId == null) {
        // New user, create a new node with push
        final userId = _database.child('users').push().key;
        await _database.child("users").child(userId!).set(userdata);
        print(currentUserId);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Profile saved successfully!")));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RootApp()));
        // ... success message for creating a new profile
      } else {
        await _database.child("users").child(currentUserId).set(userdata);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Profile saved successfully!")));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RootApp()));
        // Existing user, update data (logic shown earlier)
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              image.isNotEmpty
                  ? Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360)),
                  child: Image.network(image))
                  : SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                ),
                validator: RequiredValidator(errorText: "Please enter your name"),
                controller: _namecontroller,
                onSaved: (newValue) => name = newValue!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Contact No"),
                controller: _contactcontroller,
                onSaved: (newValue) => contact = double.parse(newValue!),
                validator: (value) {
                  if (value!.length >= 12) {
                    return ('You may have enter wrong number');
                  } else if (value.isEmpty) {
                    return ('Please Enter a number');
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "CNIC", hintText: "Enter without dashes(-)"),
                controller: _cniccontroller,
                onSaved: (newValue) => cnic = double.parse(newValue!),
                validator: (value) {
                  if (value!.length > 13) {
                    return ('NIC number should not be greater than 13');
                  } else if (value.isEmpty) {
                    return ('Please Enter a NIC number');
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "DOB",
                ),
                controller: _dobcontroller,
                onTap: () {
                  _selectDate(context);
                },
                validator: RequiredValidator(errorText: 'Please enter a date'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue)),
                  onPressed: pickImage, // Replace with your image selection logic
                  child: Text("Select PFP",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                  ),),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.greenAccent)),
                onPressed: saveUserData,
                child: Text("Save",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
