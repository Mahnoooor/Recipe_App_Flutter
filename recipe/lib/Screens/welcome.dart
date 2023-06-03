import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Screens/categories.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Authentication/Signup.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       body: Container(
         width: double.infinity, // Set the width to occupy the entire horizontal space
  height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'), // Replace with your image path
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
       
     child:  
          Padding(
            padding: EdgeInsets.symmetric(vertical:10.h,horizontal: 5.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 25.h,),
                  RichText(
              text: TextSpan(
                children: [
                  TextSpan(
              text: 'Pak ',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 36, 105, 38), // Set the color for the first word
                ),
              ),
                  ),
                  TextSpan(
              text: 'Waan',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white, // Set the color for the second word
                ),
              ),
                  ),
                ],
              ),
                    ),
                      SizedBox(height: 2.h,),
                    Text(
  'باہر کا ذائقہ گھر میں',
  style: GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      letterSpacing: 1.2, // Adjust the letter spacing for a stylized effect
      color: Color.fromARGB(255, 239, 241, 243), // Set a custom text color
      shadows: [
        Shadow(
          color: Colors.black,
          offset: Offset(2, 2),
          blurRadius: 2,
        ),
      ],
    ),
  ),
),

                      SizedBox(height: 22.h,),
                      Container(
              width: 50.w,
              height: 7.h,
              decoration: BoxDecoration(
                color: Color.fromRGBO(217, 150, 81, 1),
                borderRadius: BorderRadius.circular(22.sp),
              ),
              child: TextButton(
                onPressed: () {
                  // Handle button press
                  Get.to(Categories());
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                      ),
                      
                   
                       
                      
                      
                    
                ],
              ),
            ),
          ),
        )

       
    );
  }
}