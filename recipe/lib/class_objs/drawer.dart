import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Screens/categories.dart';
import 'package:music/Screens/home.dart';
import 'package:music/Screens/Feed.dart';
import 'package:music/Screens/welcome.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'NameController.dart';
import '../Screens/Fav.dart';

class drawer extends StatefulWidget {
  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    final NameController nameController = Get.find();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.sp),
          bottomRight: Radius.circular(20.sp),
        ),
        child: Container(
          height: 70.h,
          child: Drawer(
            width: 55.w,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 20.h,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 107, 67, 20),
                    ),
                    child: Obx(
                      () => Text(
                        nameController.name.value,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.bold,
                            
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Color.fromARGB(255, 107, 67, 20),
                      ),
                      SizedBox(width: 1.5.w),
                      Text(
                        'Home',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(217, 150, 81, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(Post());
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.food_bank,
                        color: Color.fromARGB(255, 107, 67, 20),
                      ),
                      SizedBox(width: 1.5.w),
                      Text(
                        'Categories',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(217, 150, 81, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                   Get.to(Categories());
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Color.fromARGB(255, 107, 67, 20),
                      ),
                      SizedBox(width: 1.5.w),
                      Text(
                        'Favorites',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(217, 150, 81, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(Favorites());
                  },
                ),

                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.picture_in_picture,
                        color: Color.fromARGB(255, 107, 67, 20),
                      ),
                      SizedBox(width: 1.5.w),
                      Text(
                        'Posts',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(217, 150, 81, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(Feed());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
