import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fyp_frontend/pages/root.dart';
import 'package:fyp_frontend/pages/signup_sc.dart';
import'../background.dart';
import '../widgets/login_content.dart';
import'package:fyp_frontend/theme/color.dart';
import 'package:fyp_frontend/auth/fire_auth.dart';
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return(_showError(context, 'Please enter an email'));
    }else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
      return(_showError(context, 'Please enter a valid email'));
    }else _login(context);
  }
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('helo');
      Navigator.push(context,  MaterialPageRoute(
        builder: (context) => RootApp(),
      ),);
    } catch (e) {
      print(_emailController.text);
      print(_passwordController.text);
      // Authentication failed, show error message
       String errorMessage = 'Authentication failed. Please check your email and password.';
       _showError(context, errorMessage);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 120,right: 220),
                child: Text('Login',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w600,
                  color: AppColor.shadowColor,
                ),),
                decoration: BoxDecoration(
                ),
              ),
              SizedBox(height: 100,),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child:Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: AppColor.textBoxColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [BoxShadow(
                          color: AppColor.shadowColor,
                          spreadRadius: 1,
                          blurRadius: 3
                      )]
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child:Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: AppColor.textBoxColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [BoxShadow(
                          color: AppColor.shadowColor,
                          spreadRadius: 1,
                          blurRadius: 3
                      )]
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      prefixIcon: Icon(Icons.email_outlined),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    child: Text('Forgot Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => signup(),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 50),
                      child: Text('Create new Account',
                      style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: Colors.black,

                      ),),),
                  ),
                ],
              ) ,
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(AppColor.shadowColor),
                            backgroundColor: MaterialStateProperty.all<Color>(AppColor.textBoxColor)
                        ),
                        onPressed: () {
                          _validateEmail(_emailController.text);
                        },
                        child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
