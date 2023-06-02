import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class DrumStick extends StatefulWidget {
  const DrumStick({Key? key}) : super(key: key);

  @override
  State<DrumStick> createState() => _DrumStickState();
}

class _DrumStickState extends State<DrumStick> {
  bool isPressed = false;
  //
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
        .where('title', isEqualTo: 'DrumStick')
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
        .where('title', isEqualTo: 'DrumStick')
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
        'title': 'DrumStick', // Provide the recipe details
        'imageUrl': 'assets/dd.jpg',
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


   List<String> ingredients = 
[
"1 tsp smoked paprika",
"1/2 tsp garlic powder",
"1/4 tsp onion powder",
"1/8 tsp cayenne pepper",
"1/4 tsp dried oregano",
"1/2 tsp salt",
"1/4 tsp freshly cracked black pepper",
"1.75 lbs. chicken drumsticks (6 pieces)",
"2 Tbsp cooking oil"
];
  List<String> DrumStickSteps = [
"Preheat the oven to 425ºF.",
"Combine the smoked paprika, garlic powder, onion powder, cayenne pepper, oregano, salt, and pepper in a bowl.",
"Place the chicken drumsticks in a bowl and drizzle the cooking oil over top.",
"Sprinkle the prepared seasoning over the drumsticks, then toss until they're evenly coated in oil and spices.",
"Place the seasoned drumsticks on a baking sheet with enough space around each so they're not touching. You can line the baking sheet with foil or parchment for easier cleanup, if desired.",
"Transfer the chicken to the oven and bake for 40 minutes, or until they reach an internal temperature of 175ºF, flipping the drumsticks once half-way through.",
"Serve hot."
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
                  'assets/dd.jpg',
                  width: double.infinity,
                  height: 38.h,
                  fit: BoxFit.cover,
                ),
      Positioned(
        top: 20,
        left: 10,
        child:IconButton(
        icon: Icon(Icons.keyboard_arrow_left, size: 25.sp, color: Colors.white),
        onPressed: () {
         Get.back();
        },
          ),
        
      ),
      
      
              ],
            ),
            /////////
            SizedBox(height: 3.h,),
            Padding(
              padding: EdgeInsets.only(left:30.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
             Text(
                          'DrumStick',
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
                        'FastFood',
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
                        '40 minutes',
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
        padding: EdgeInsets.only(left:20.sp),
        child: Align(
          alignment: Alignment.topLeft,
          child:  Text(
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
        padding:  EdgeInsets.symmetric(vertical:4.h,horizontal: 5.w),
        child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: DrumStickSteps.map((step) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Text(
        '- $step',
        style: TextStyle(fontSize: 17.sp),
      ),
    );
  }).toList(),
),
      )

          
          ],
        ),
      ),
    );
  }
}
