import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_frontend/pages/edit_profile.dart';
import 'package:fyp_frontend/pages/login_sc.dart';
import 'package:fyp_frontend/theme/color.dart';
import '../auth/fire_auth.dart';
import'../background.dart';
class signup extends StatelessWidget {
  const signup({super.key});
  _showeeror( context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message),
          backgroundColor:AppColor.red,
        )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService _authService = FirebaseAuthService();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 80,right: 200),
                  child: Text('Sign Up',
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w600,
                        color: AppColor.shadowColor,
                    ),),
                  decoration: BoxDecoration(
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 180),
                  child: Text('Signup to continue',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color:AppColor.darker,
                    ),
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
                      validator:(value){
                        if (value!.isEmpty){
                          _showeeror(context, 'Please Enter an Email');
                        }
                      },
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
                  child: Container(
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
                      obscureText: false,
                      controller: _passwordController,
                      validator: (value){
                        if(value!.isEmpty){
                         _showeeror(context, 'Enter a Password');
                        }else if(value.length<6){
                          _showeeror(context, 'Password must be greater than 6 characters');
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Container(
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
                      obscureText: false,
                      validator:(value){
                        if(_passwordController.text!=value){
                          _showeeror(context, 'Password does not match');
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => login(),
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                    },
                    child: Text('Already have an Account?',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),),
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                  child: SizedBox(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(AppColor.shadowColor),
                          backgroundColor: MaterialStateProperty.all<Color>(AppColor.textBoxColor)
                      ),
                      onPressed: ()async{
                        if(_formKey.currentState!.validate()){
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          User? user = await _authService.signUpWithEmailAndPassword(email, password);
                          if (user != null) {
                            Navigator.push(context,  MaterialPageRoute(
                              builder: (context) => saveuser(),
                            ),);
                          } else {
                           _showeeror(context, 'Network Error');
                          }
                        }
                      },
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            fontSize: 18,
                        ),
                      ),),

                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
