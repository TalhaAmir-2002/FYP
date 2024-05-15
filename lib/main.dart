import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_frontend/pages/root.dart';
import 'package:fyp_frontend/pages/signup_sc.dart';
import 'package:fyp_frontend/theme/color.dart';
import 'package:fyp_frontend/utils/data.dart';
import 'package:fyp_frontend/utils/getuser.dart';
import 'package:provider/provider.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'xxx',
        appId: '1:485628784163:android:5c1bf27a747b94178e0b96',
        messagingSenderId: '485628784163',
        projectId: 'project-69c73',
        storageBucket: 'project-69c73.appspot.com',
      )
  );
  fetchDataLocally();
  runApp(ChangeNotifierProvider(
    create: (context) => UserData(),
    child: MyApp(),
  ),);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColor.primary
      ),
      home: signup(),
    );
  }
}
