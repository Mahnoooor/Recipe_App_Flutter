

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Authentication/login.dart';
import 'package:music/class_objs/drawer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../class_objs/NameController.dart';
import '../Screens/categories.dart';


//sign upp
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final NameController nameController = Get.put(NameController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(7.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 3.h),
                Center(
                  child: Image(
                    image: AssetImage('assets/img.png'),
                    width: 70.w,
                    height: 20.h,
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                
                Text( 'First create your account 👩‍🍳',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 211, 138, 55), 
                ),
              )),
                Column(
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),

                    //namee
                    Formfields(text: 'Name', icon: Icons.person, controller: name,  
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },),

                    SizedBox(
                      height: 3.h,
                    ),

////email
                    
Formfields(text: 'Email', icon: Icons.email, controller:email, validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!GetUtils.isEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },),
                    
                    SizedBox(
                      height: 3.h,
                    ),

                    //password
                    
                      Formfields(text: 'Password', icon: Icons.visibility_off_rounded, controller: password,validator:(value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password should be at least 6 characters';
                        }
                        return null;
                      },obscureText: true,),

                    SizedBox(
                      height: 2.h,
                    ),

                  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Already have an account", textAlign: TextAlign.right,style: TextStyle(fontSize: 16.sp,color: Colors.black),),
          TextButton(onPressed: (){
            Get.to(Login());
          }, child: Text("LogIn", textAlign: TextAlign.right,style: TextStyle(fontSize: 16.sp,color: Color.fromARGB(255, 204, 135, 44), fontWeight: FontWeight.bold),)),
            
          ],
        ),
                    SizedBox(
                      height: 2.h,
                    ),

                    //sign upp
                    Container(
                      width: 50.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        color: Color.fromRGBO(217, 150, 81, 1),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var UserName = name.text.trim();
                            var UserEmail = email.text.trim();
                            var UserPassword = password.text.trim();

                            try {
                              await _auth.createUserWithEmailAndPassword(
                                email: UserEmail,
                                password: UserPassword,
                              ).then((value) {
                                print('user created');
                               nameController.name.value = UserName;
                                Get.to(Categories());
                              });
                            } catch (e) {
                              print(e.toString());
                            }
                          }
                        },
                        child: Text(
                          "Sign Up",
                          textAlign: TextAlign.right,
                         style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                 
                  color: Colors.white, // Set the color for the second word
                ),
              ),
                       
                        
                    ),)
                  )

                  ],
                ),
              
               
            ],
        ),
      ),
    ),
      )
        );
     
   
  }
}

class Formfields extends StatelessWidget {
     final String text;
  final IconData icon;
final Function(String)? validator;
final VoidCallback? push;
 final bool obscureText;
  const Formfields({
    super.key,
    required this.text, required this.icon, this.validator, required this.controller, this.obscureText = false, this.push, 
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
       obscureText: obscureText,
            decoration: InputDecoration(
        labelText: text,
        labelStyle:TextStyle(color:Colors.black),
        fillColor: Colors.white.withOpacity(0.2),
       filled: true,
       suffixIcon: Icon(icon,color:  Colors.black.withOpacity(0.8),),
        focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 204, 135, 44)), // Customize the border color here
    ),
enabledBorder: UnderlineInputBorder(
  borderSide: BorderSide(color: Color.fromARGB(255, 204, 135, 44))
)
   
      ),
    
    );
  }
}
