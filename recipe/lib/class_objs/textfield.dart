import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Textformm extends StatefulWidget {
   final IconData? icon;
  final String text;
   final TextEditingController controller;
  
  const Textformm({Key? key, this.icon, required this.text,  required this.controller}) : super(key: key);

  @override
  State<Textformm> createState() => _TextformmState();
}

class _TextformmState extends State<Textformm> {
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
        style: const TextStyle(color: Colors.black),//input text color
    decoration: InputDecoration(
      
      prefixIcon: Icon(widget.icon, color: Colors.black.withOpacity(0.4),),
      hintText: widget.text,
      hintStyle:TextStyle(color:Colors.black),
      fillColor: Colors.white.withOpacity(0.2),
     filled: true,
   //TextStyle(fontSize: 20.0, color:Colors.white),
     focusedBorder:  OutlineInputBorder(
        borderSide:
              BorderSide(width: 1, color: Colors.black), 
        borderRadius: BorderRadius.circular(25.sp),
     ),
      enabledBorder: OutlineInputBorder(
        borderSide:
              BorderSide(width: 1, color: Colors.black), 
        borderRadius: BorderRadius.circular(25.sp),
     )
    ),

 );
  }
}