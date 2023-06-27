
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Screens/category/Desi/biryani.dart';
import 'package:music/Screens/category/Desi/kofta.dart';
import 'package:music/Screens/category/Desi/korma.dart';
import 'package:music/Screens/category/Desi/nehari.dart';
import 'package:music/Screens/category/Desi/palao.dart';
import 'package:music/Screens/category/chinese/Chowmein.dart';
import 'package:music/Screens/category/chinese/Noodlesoup.dart';
import 'package:music/Screens/category/chinese/dumpling.dart';
import 'package:music/Screens/category/chinese/wonton.dart';
import 'package:music/Screens/category/fastfood/drumstick.dart';
import 'package:music/Screens/category/fastfood/fries.dart';
import 'package:music/Screens/category/fastfood/taco.dart';
import 'package:music/Screens/category/fastfood/zinger.dart';
import 'package:music/class_objs/drawer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Favorites extends StatefulWidget {
  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
      final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      key:_scaffoldKey,
      drawer: drawer(),
      
    body: Padding(
       padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu_rounded, size: 25.sp),
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      SizedBox(width: 5.w),
                      Center(
                        child: Text(
                          'Saved Recipes',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                             
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
           Container(
              width: 45.w,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userId)
                    .collection('saved_recipes')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text('No saved recipes found.', style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),),
                    );
                  }
                  return SingleChildScrollView(
                    child: ListView.builder(
                       shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var recipe = snapshot.data!.docs[index];
                        // Extract recipe details from the snapshot
                        String title = recipe['title'];
                        String imageUrl = recipe['imageUrl'];
                        String recipeId = recipe.id;
                            
                        return SizedBox(
                          width: 45.w,
                          child: GestureDetector(
                        onTap: () {
                        if (title == 'Korma') {
                        Get.to(Korma());
                        } else if (title == 'Palao') {
                        Get.to(Palao());
                        } else if (title == 'Biryani') {
                        Get.to(Biryani());
                        } else if (title == 'Kofta') {
                        Get.to(Kofta());
                        } else if (title == 'Nehari') {
                        Get.to(Nehari());
                        } else if (title == 'Zinger') {
                        Get.to(Zinger());
                        } else if (title == 'Tacos') {
                        Get.to(Taco());
                        } else if (title == 'DrumStick') {
                        Get.to(DrumStick());
                        } else if (title == 'Loaded Fries') {
                        Get.to((LoadedFies()));
                        } else if (title == 'Chowmein') {
                        Get.to((Chowmein()));
                        } else if (title == 'Dumplings') {
                        Get.to(Dumpling());
                        } else if (title == 'Noodle Soup') {
                        Get.to(NoodleSoup());
                        } else if(title=='Wonton')
                        {
                      Get.to(Wonton());
                        }
                         else {
                        // Handle other recipes or show an error message
                        print('Recipe screen not found for $title');
                        }
                      },
                      
                      
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              elevation: 4.0,
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    imageUrl,
                                    height: 15.h,
                                    width: 45.w,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 2.h),
                                  Container(
                                    height: 7.h,
                                    width: 42.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.sp),
                                        bottomRight: Radius.circular(10.sp),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          
          ],
        ),
      ),
    )

    );
  }
}

