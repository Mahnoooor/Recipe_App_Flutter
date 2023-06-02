import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class Wonton extends StatefulWidget {
  const Wonton({Key? key}) : super(key: key);

  @override
  State<Wonton> createState() => _WontonState();
}

class _WontonState extends State<Wonton> {
  bool isPressed = false;
  ///
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
          .where('title', isEqualTo: 'Wonton')
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
          .where('title', isEqualTo: 'Wonton')
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
          'title': 'Wonton', // Provide the recipe details
          'imageUrl': 'assets/w.jpg',
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
  "1 boneless chicken breast, finely chopped",
  "1/2 cup prawns, finely chopped",
  "1 tbsp coriander leaves, finely chopped",
  "1 tsp soy sauce",
  "1/2 tsp white pepper",
  "1/2 tsp salt",
  "1/2 cup flour"
];
  List<String> WontonSteps = [
"For the filling, in a medium bowl, combine the chicken breast, prawns, salt, white pepper, soy sauce, and coriander leaves. Set aside.",
"For the dough, sieve the flour in a bowl. Add salt and beaten eggs. Knead a hard dough using water. Cover with a wet cloth and let it rest for 30 minutes.",
"Roll the dough into a thin rectangular shape.",
"Cut the rolled dough into 3x3 inch squares.",
"Place 1 teaspoon of filling on the corner edge of each dough square.",
"Fold the dough square into a wonton shape, sealing the edges with beaten eggs.",
"Heat oil in a deep pan or wok over medium heat.",
"Deep fry the wontons for about 5 minutes or until they turn crispy and golden.",
"Remove the fried wontons from the oil and drain them on a paper towel to remove excess oil.",
"The fried wontons are now ready to be served. Enjoy!"
"Serve with Chinese Plum Sauce."
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
                  'assets/w.jpg',
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
                          'Wonton',
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
                        'Chinese',
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
                        '1 hr',
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
  children: WontonSteps.map((step) {
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
