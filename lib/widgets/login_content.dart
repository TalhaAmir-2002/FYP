// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../theme/color.dart';
//
// class RoundedTextField extends StatelessWidget {
//   final String hintText;
//   final IconData icon;
//    final bool obscureText;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   RoundedTextField({
//     required this.hintText,
//     required this.icon,
//      required this.obscureText,
//     this.validator,
//     this.controller,
//   });
//
//   @override
//
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         color: AppColor.textBoxColor,
//         borderRadius: BorderRadius.circular(15.0),
//         boxShadow: const [BoxShadow(
//           color: AppColor.shadowColor,
//           spreadRadius: 1,
//           blurRadius: 3
//         )]
//       ),
//       child: TextField(
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           hintText: hintText,
//           prefixIcon: Icon(icon),
//           suffixIcon: obscureText
//           ? InkWell(
//             onTap: (){
//               setState(() {
//               });
//                           },
//             child: Icon(Icons.visibility),
//           ):null,
//           contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }