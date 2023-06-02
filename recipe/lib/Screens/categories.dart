import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Screens/category/chinese/chinese.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../class_objs/card1.dart';
import '../class_objs/drawer.dart';
import '../class_objs/textfield.dart';
import 'category/Desi/desi.dart';
import 'category/fastfood/fast.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchController = TextEditingController();
  List<String> categories = ['Desi', 'Chinese', 'Fast Food'];
  List<String> categoryImages = [
    'assets/n.png',
    'assets/c.jpg',
    'assets/b.jpg',
  ];
  List<void Function()> cardTaps = [
    () {
    Get.to(Desi_category());
    },
    () {
    Get.to(Chinese_Category());
    },
    (){
      Get.to(Fast_category());
    }
    // Add more functions for other cards
  ];
  String searchQuery = '';
  List<String> filteredCategories = [];
  List<String> filteredCategoryImages = [];

  void filterCategories() {
    if (searchQuery.isNotEmpty) {
      filteredCategories = categories
          .where((category) =>
              category.toLowerCase().startsWith(searchQuery.toLowerCase()))
          .toList();
      filteredCategoryImages = filteredCategories.map((category) {
        int index = categories.indexOf(category);
        return categoryImages[index];
      }).toList();
    } else {
      filteredCategories = categories;
      filteredCategoryImages = categoryImages;
    }
  }

  @override
  void initState() {
    super.initState();
    filterCategories(); // Initial filtering
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
      });
      filterCategories(); // Update filtering on text change
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
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
                  Text(
                    'Categories',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Textformm(
                text: 'search',
                icon: Icons.search,
                controller: _searchController,
              ),
              SizedBox(height: 3.h),
              if (filteredCategories.isEmpty)
                Text('No item found'),
              Column(
                children: List.generate(filteredCategories.length, (index) {
                  return Card1(
                    image: filteredCategoryImages[index],
                    text: filteredCategories[index],
                    text2: '4 Recipes',
                    tap: cardTaps[index],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
