import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Authentication/login.dart';
import 'package:music/Screens/home.dart';
import 'package:music/Screens/welcome.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'Authentication/Signup.dart';
import 'Screens/categories.dart';
import 'Screens/category/Desi/biryani.dart';
import 'Screens/category/Desi/desi.dart';
import 'Screens/category/Desi/desi.dart';
import 'Screens/category/Desi/korma.dart';
import 'Screens/category/Desi/nehari.dart';
import 'Screens/category/Desi/palao.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/category/chinese/chinese.dart';
import 'Screens/category/chinese/dumpling.dart';
import 'Screens/Fav.dart';
import 'Screens/Feed.dart';


void main() async {
     WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        
    return  GetMaterialApp(
    
               debugShowCheckedModeBanner: false,

      home:Feed(),
      
    );
      }
    );
  }
}
