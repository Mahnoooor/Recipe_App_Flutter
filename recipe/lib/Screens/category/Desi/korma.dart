import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Korma extends StatefulWidget {
  const Korma({Key? key}) : super(key: key);

  @override
  State<Korma> createState() => _KormaState();
}

class _KormaState extends State<Korma> {
 final FirebaseAuth _auth = FirebaseAuth.instance;
  late RxBool isRecipeSaved;

  @override
  void initState() {
    super.initState();
    isRecipeSaved = false.obs;
    checkIfRecipeSaved();
  }

  Future<void> checkIfRecipeSaved() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;
      final recipeRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('saved_recipes');

      final recipeSnapshot = await recipeRef
          .where('title', isEqualTo: 'Korma')
          .limit(1)
          .get(); // Check if the recipe is already saved

      setState(() {
        isRecipeSaved.value = recipeSnapshot.docs.isNotEmpty;
      });
    }
  }

  Future<void> toggleFavoriteRecipe() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;
      final recipeRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('saved_recipes');

      final recipeSnapshot = await recipeRef
          .where('title', isEqualTo: 'Korma')
          .limit(1)
          .get(); // Check if the recipe is already saved

      if (recipeSnapshot.docs.isNotEmpty) {
        // Recipe exists, delete it from favorites
        final recipeId = recipeSnapshot.docs.first.id;
        await recipeRef.doc(recipeId).delete();

        setState(() {
          isRecipeSaved.value = false; // Update the saved state to false
        });

        Get.snackbar(
        'Recipe Removed',
        'Recipe removed from favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
      } else {
        // Recipe doesn't exist, save it in favorites
        // Save the recipe in the user's collection
        await recipeRef.add({
          'title': 'Korma', // Provide the recipe details
          'imageUrl': 'assets/k.jpg',
          // Add other recipe details here
        });

        setState(() {
          isRecipeSaved.value = true; // Update the saved state to true
        });

       Get.snackbar(
        'Recipe Saved',
        'Recipe saved to favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
      }
    }
  }

  List<String> ingredients = [
    '1/2 Kg chicken',
    '1 cup oil',
    '2-3 tsp ghee',
    '8-10 Cardamoms',
    '6-7 Cloves',
    '2 tbsp garlic',
    '1 tbsp coriander powder',
    '1 tbsp chili powder (to taste)',
    'salt (to taste)',
    '1 tsp ginger paste',
    '1 cup yogurt',
    '2 onions (fried, puree this with the yogurt), sliced',
    '1 tsp garam masala',
    'Few strands of saffron (mixed in 3 tsp of water)',
    'coriander leaves, chopped (for garnishing)'
  ];

  List<String> KormaSteps = [
    'Heat the vegetable oil into the pan, then put a dollop of ghee.',
    'Put cardamom, cloves, garlic and fry the mix properly.',
    'Then add the chicken and let it cook for about 2-3 minutes.',
    'Keep stirring it.',
    'Once it becomes brown, add coriander and chili powder.',
    'Add salt to taste.',
    'Add ginger paste, mixture of fried onions and yogurt, let it cook for a minute.',
    'Then put garam masala and saffron for flavor.',
    'If the gravy is too thick add a little bit of water before covering it. The masala should fuse well with the chicken.',
    'Cover it and give it some time to cook on slow fire. Let it simmer for about 10-15 minutes.',
    'Keep stirring occasionally.',
    'Serve hot, garnished with coriander leaves.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/k.jpg',
                  width: double.infinity,
                  height: 38.h,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left, size: 25.sp, color: Colors.white),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h,),
            Padding(
              padding: EdgeInsets.only(left: 30.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Korma',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w,),
                  //LIKED BUTTON FOR BACKEND
                  Obx(
                    () => IconButton(
                      onPressed: toggleFavoriteRecipe,
                      icon: Icon(
                        isRecipeSaved.value ? Icons.favorite : Icons.favorite_border_rounded,
                        color: Colors.red[700],
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h,),
            Text(
              'Desi',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.alarm_rounded),
                SizedBox(width: 2.w,),
                Text(
                  '45 minutes',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h,),
            Container(
              width: 55.w,
              height: 7.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(217, 150, 81, 1),
                ),
                borderRadius: BorderRadius.circular(20.sp),
              ),
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Color.fromARGB(255, 214, 180, 128),
                        child: Container(
                          padding: EdgeInsets.all(16.sp),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'Ingredients: ',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: ingredients.map((ingredient) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 1.h),
                                      child: Text(
                                        '- ' + ingredient,
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'View Ingredients',
                  style: TextStyle(
                    color: Color.fromRGBO(217, 150, 81, 1),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            SizedBox(
              width: double.infinity,
              child: Divider(
                color: Colors.black.withOpacity(0.5),
                thickness: 1.0,
              ),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding: EdgeInsets.only(left: 20.sp),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Steps:',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: KormaSteps.map((step) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.5.h),
                    child: Text(
                      '- $step',
                      style: TextStyle(fontSize: 17.sp),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
