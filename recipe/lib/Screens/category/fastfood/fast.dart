import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Screens/category/fastfood/drumstick.dart';
import 'package:music/Screens/category/fastfood/fries.dart';
import 'package:music/Screens/category/fastfood/taco.dart';
import 'package:music/Screens/category/fastfood/zinger.dart';
import 'package:music/class_objs/card2.dart';
import 'package:music/class_objs/drawer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Fast_category extends StatefulWidget {
  @override
  State<Fast_category> createState() => _Fast_categoryState();
}

class _Fast_categoryState extends State<Fast_category> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body:Stack(
          children: [
            Positioned(
              top: 30.sp,
            
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu_rounded, size: 25.sp),
                      onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                        },
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Fast Food Recipes',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height:80.h,
                width: double.infinity,
                decoration: BoxDecoration(
     color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.sp),
      topRight: Radius.circular(30.sp),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.brown.withOpacity(0.8),
        offset: Offset(0.0, 5.sp), 
        blurRadius: 15.sp, 
      ),
    ],
  ),
     child: Padding(
          padding: EdgeInsets.only(top: 8.h, left: 6.6.w),
       child: SingleChildScrollView(
         child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [
Card2(text: 'Zinger Burger', image: 'assets/b.jpg', tap: (){
  Get.to(Zinger());
}),
SizedBox(width: 2.w,),
Card2(text: 'Tacos', image: 'assets/t.jpg', tap: (){
  Get.to(Taco());
})
            ],),
SizedBox(height: 2.h,),
              Row(children: [
Card2(text: 'DrumSticks', image: 'assets/dd.jpg', tap: (){
  Get.to(DrumStick());
}),
SizedBox(width: 2.w,),
Card2(text: 'LoadedFries', image: 'assets/ll.jpeg', tap: (){
  Get.to(LoadedFies());
})
            ],),
SizedBox(height: 2.h,),
              Row(children: [

SizedBox(width: 2.w,),

            ],),
            
          ],
         ),
       ),
     ),          
              ),
            ),
          ],
        ),
   
    );
  }
}
