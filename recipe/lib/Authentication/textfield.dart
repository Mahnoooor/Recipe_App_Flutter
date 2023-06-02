import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class Textfield extends StatefulWidget {
 
  final String text;
  final IconData icon;
// final Function(String)? validator;
 const Textfield({Key? key, required this.text, required this.icon}) : super(key: key);
// required controller
  @override
  State<Textfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
//    final _formKey = GlobalKey<FormState>();
//  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Form(
      // key: _formKey,
      child: Container(
        width: 100.w,
        child: TextFormField(
          // controller: myController,
            style: const TextStyle(color: Colors.black),
            //input text color
        decoration: InputDecoration(
          labelText: widget.text,
          hintStyle:TextStyle(color:Colors.black),
          fillColor: Colors.white.withOpacity(0.2),
         filled: true,
         suffixIcon: Icon(widget.icon),
       //TextStyle(fontSize: 20.0, color:Colors.white),
         focusedBorder:  OutlineInputBorder(
            borderSide:
                  BorderSide(width: 2.sp, color: Colors.black), 
            borderRadius: BorderRadius.circular(12.sp),
         ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                  BorderSide(width: 1.sp, color: Colors.grey), 
            borderRadius: BorderRadius.circular(12.sp),
         )
        ),
    //  validator: (value) {
    //         if (widget.validator != null) {
    //           return widget.validator!(value!);
    //         }
    //         return null;
    //       },
     ),
      ),
    );
  }
}