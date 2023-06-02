import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Screens/category/Desi/biryani.dart';
import 'package:music/Screens/category/Desi/kofta.dart';
import 'package:music/Screens/category/Desi/korma.dart';
import 'package:music/Screens/category/Desi/nehari.dart';
import 'package:music/Screens/category/Desi/palao.dart';
import 'package:music/class_objs/card2.dart';
import 'package:music/class_objs/drawer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Desi_category extends StatefulWidget {
  @override
  State<Desi_category> createState() => _Desi_categoryState();
}

class _Desi_categoryState extends State<Desi_category> {
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
                      'Desi Food Recipes',
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
Card2(text: 'Nehari', image: 'assets/n.png', tap: (){
  Get.to(Nehari());
}),
SizedBox(width: 2.w,),
Card2(text: 'Biryani', image: 'assets/b 1.png', tap: (){
  Get.to(Biryani());
})
            ],),
SizedBox(height: 2.h,),
              Row(children: [
Card2(text: 'Korma', image: 'assets/k.jpg', tap: (){
  Get.to(Korma());
}),
SizedBox(width: 2.w,),
Card2(text: 'Palau', image: 'assets/p.jpg', tap: (){
  Get.to(Palao());
})
            ],),
SizedBox(height: 2.h,),
              Row(children: [
Card2(text: 'Kofte', image: 'assets/kk.jpg', tap: (){
  Get.to(Kofta());
}),
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
