import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Palao extends StatefulWidget {
  const Palao({Key? key}) : super(key: key);

  @override
  State<Palao> createState() => _PalaoState();
}

class _PalaoState extends State<Palao> {
  bool isPressed = false;
  ///firebase:
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
          .where('title', isEqualTo: 'Palao')
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
          .where('title', isEqualTo: 'Palao')
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
          'title': 'Palao', // Provide the recipe details
          'imageUrl': 'assets/p.jpg',
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
  "2 cups soaked basmati rice",
  "1/2 medium onion",
  "1/2 teaspoon peppercorns",
  "2 inches cinnamon stick",
  "1/2 teaspoon nutmeg powder",
  "6 cloves garlic",
  "1 teaspoon coriander seeds",
  "salt (as required)",
  "1/2 teaspoon crushed ginger paste",
  "1/2 medium chopped tomato",
  "1/2 cup yogurt (curd)",
  "1/2 teaspoon red chili powder",
  "2 green cardamom",
  "100 gm ghee",
  "500 gm chicken, chopped into cubes",
  "2 black cardamom",
  "1/2 teaspoon clove",
  "1 bay leaf",
  "1/2 teaspoon mace powder",
  "2 inches ginger",
  "4 cups water",
  "1/4 medium sliced onion",
  "1/2 teaspoon crushed garlic paste",
  "1 teaspoon cumin seeds",
  "1/2 teaspoon coriander powder",
  "1 teaspoon garam masala powder",
  "1 1/2 teaspoon fennel seeds"
];

  List<String> PalaoSteps = [
  "Take a clean muslin cloth and tie the cubed onion pieces, garlic pods, whole ginger, bay leaf, black cardamom pods, black peppercorns, coriander seeds, cloves, cinnamon stick, nutmeg, and mace in it. This is called bouquet garni.",
  "Wash the chicken and keep aside. In a cooking pot, take 3 cups water, cubed chicken and a teaspoon of salt. Turn on the flame. Add to it, the bouquet garni and boil for around 20 minutes or until chicken gets done.",
  "Remove the bouquet garni and keep the stock with chicken pieces aside. The 'yakhni' is ready.",
  "In a pan, heat ghee and fry onions. Keep 1/4th of it aside for adding later.",
  "In the remaining onions, add cumin seeds, ginger-garlic paste, tomatoes, salt, red chilli powder, coriander powder and stir fry for 3 minutes. Add yoghurt, garam masala and green cardamom. Cook on medium-high heat till the tomatoes get tender. Add fennel seeds and chicken pieces to the masala and let it simmer for another 2 minutes.",
  "Add this masala to the prepared yakhni (stock) in the cooking pot, turn on the heat and cook the rice uncovered for 5 minutes. Sprinkle fried onions that we saved in step 4 on the rice, add a tbsp of ghee and seal the pot with foil or atta dough so that the flavours do not escape.",
  "Cook on a low heat for 15 minutes or till the rice is done.",
  "Enjoy the hot Yakni Pulao with cucumber raita."
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
                  'assets/p.jpg',
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
                          'Palao',
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
                        '1h 5m',
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
  children: PalaoSteps.map((step) {
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
