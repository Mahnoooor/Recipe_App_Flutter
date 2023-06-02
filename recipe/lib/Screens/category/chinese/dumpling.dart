import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class Dumpling extends StatefulWidget {
  const Dumpling({Key? key}) : super(key: key);

  @override
  State<Dumpling> createState() => _DumplingState();
}

class _DumplingState extends State<Dumpling> {
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
          .where('title', isEqualTo: 'Dumplings')
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
          .where('title', isEqualTo: 'Dumplings')
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
          'title': 'Dumplings', // Provide the recipe details
          'imageUrl': 'assets/d.jpg',
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
  "4 cups all-purpose flour (500 g)",
  "2 teaspoons salt, divided",
  "1 ¼ cups warm water (300 mL)",
  "2 cups red cabbage (200 g)",
  "2 cups green onion (300 g), sliced",
  "6 cloves garlic, minced",
  "4 tablespoons ginger, minced",
  "2 tablespoons soy sauce",
  "2 tablespoons sesame oil",
  "½ lb ground pork (225 g)",
  "½ teaspoon pepper",
  "¾ cup mushroom (55 g), diced",
  "¾ cup carrot (90 g), diced",
  "½ lb shrimp (225 g), peeled and deveined",
  "¼ cup soy sauce (60 mL) - for dipping sauce",
  "¼ cup rice wine vinegar (60 mL) - for dipping sauce",
  "1 teaspoon sesame oil - for dipping sauce",
  "1 teaspoon crushed red pepper flake - for dipping sauce"
];
  List<String> DumplingSteps = [
"In a large bowl, combine the flour, 1 teaspoon of salt, and the warm water and mix until well-combined.",
"Roll out dough on a floured surface and knead until smooth.",
"Divide the dough into 4 equal parts.",
"Roll out 1 piece of dough into a thin log and divide into 6 or 8 pieces, depending on the size of dumplings you want. Repeat with the remaining dough portions.",
"Lightly flour the dough pieces and roll out 1 piece into a thin circle roughly 4-inches (10 cm) in diameter.",
"Keep the dumpling wrappers separated with a small piece of parchment paper and repeat with the remaining dough.",
"Combine the cabbage, green onions, garlic, ginger, soy sauce, and sesame oil in a medium bowl and mix until well-incorporated.",
"For the chicken filling, combine the ground chicken with the remaining teaspoon of salt, the pepper and 1 cup (125g) of the cabbage mixture and stir until well-incorporated.",
"For the veggie filling, combine the mushrooms and carrot and microwave for 3 minutes, until soft. Add 1 cup (125g) of the cabbage mixture and stir until well-incorporated.",
"For the shrimp filling, combine the shrimp with 1 cup (125g) of the cabbage mixture and stir until well-incorporated.",
"To assemble the dumplings, add roughly 1 heaping tablespoon of filling to the center of a dumpling wrapper. With your finger, lightly coat half of the outside of the wrapper with water. Fold the moistened half of the wrapper over the filling and, using your fingers, pleat the edges to seal. Repeat with the remaining fillings and wrappers.",
"Heat the oil over medium-high in a large skillet and add a few dumplings, cooking them in batches. Once the bottoms of the dumplings start to brown, add a splash of water and cover with a lid. Steam for about 5 minutes, or until the dumplings are cooked and the water has evaporated. Transfer the cooked dumplings to a paper towel-lined plate to remove any excess moisture or grease.",
"In a small bowl, combine the soy sauce, rice vinegar, sesame oil, and pepper flakes and stir to combine.",
"Serve the dumplings immediately with the dipping sauce."
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
                  'assets/d.jpg',
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
                          'Dumpling',
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
                        '55 minutes',
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
  children: DumplingSteps.map((step) {
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
