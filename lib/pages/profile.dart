import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_frontend/pages/edit_profile.dart';
import 'package:fyp_frontend/pages/favs.dart';
import 'package:fyp_frontend/pages/listproperty.dart';
import 'package:fyp_frontend/pages/myproperties.dart';
import 'package:fyp_frontend/theme/color.dart';
import 'package:provider/provider.dart';

import '../utils/data.dart';
import '../widgets/custom_image.dart';
import 'package:fyp_frontend/utils/getuser.dart';

import 'login_sc.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Consumer<UserData>(
      builder:(context,userdata,child){
        return Scaffold(
          backgroundColor: AppColor.appBgColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: AppColor.darker,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Reduced space
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImage(
                      userdata.image,
                      width: 75,
                      height: 75,
                      trBackground: true,
                      borderColor: AppColor.primary,
                      radius: 10,
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Text(
                  userdata.name,
                  style: const TextStyle(fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColor.darker,
                  ),
                ),
                const SizedBox(height: 15), // Reduced space
                Container(// Reduced padding
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.shadowColor,
                        spreadRadius: 0.1,
                      )
                    ],
                  ),
                  width: screenWidth - 50,
                  child: Column(
                    children: [
                      _buildListTile(title: 'Profile',
                          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>saveuser()));},
                          leading: Icon(Icons.account_circle,color: Colors.orangeAccent,)),
                      Divider(indent: 20, endIndent: 20, height: 0), // Reduced space
                      _buildListTile(title: 'My Properties',
                          onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>myproperty()));
                          },
                          leading: Icon(Icons.circle_notifications_rounded,color: Colors.blueAccent,)),
                      Divider(indent: 20, endIndent: 20, height: 0), // Reduced space
                      _buildListTile(title: 'Change Password',
                          onTap: () {},
                          leading: Icon(Icons.lock_outline_rounded,color: Colors.greenAccent,)),
                    ],
                  ),
                ),
                const SizedBox(height: 18), // Reduced space
                Container(// Reduced padding
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.shadowColor,
                        spreadRadius: 0.1,
                      )
                    ],
                  ),
                  width: screenWidth - 50,
                  child: Column(
                    children: [
                      _buildListTile(title: 'Add Property',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPropertyScreen()));
                          },
                          leading: Icon(Icons.house_outlined,color: Colors.black54,)),
                      Divider(indent: 20, endIndent: 20, height: 0), // Reduced space
                      _buildListTile(title: 'Favorites',
                          onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>favs()));
                          },
                          leading: Icon(Icons.favorite,color: Colors.redAccent,)),
                      Divider(indent: 20, endIndent: 20, height: 0), // Reduced space
                      _buildListTile(title: 'Privacy Policy',
                          onTap: () {},
                          leading: Icon(Icons.privacy_tip_rounded,color: Colors.grey,)),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Reduced space
                Container(// Reduced padding
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.shadowColor,
                        spreadRadius: 0.1,
                      )
                    ],
                  ),
                  width: screenWidth - 50,
                  child: Column(
                    children: [
                      _buildListTile(title: 'Logout',
                        onTap: () async {
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          await _auth.signOut();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                        },
                        leading: Icon(Icons.logout,color: Colors.redAccent,),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
Widget _buildListTile({
  required String title,
  String? subtitle,
  required VoidCallback onTap,
  Widget? trailing,
  Widget? leading,
}) {
  return InkWell(
    onTap: onTap,
    child: ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios),
      leading: leading,
    ),
  );
}
