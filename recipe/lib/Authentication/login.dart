import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/Authentication/Signup.dart';
import 'package:music/Screens/categories.dart';
import 'package:music/Screens/welcome.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../class_objs/NameController.dart';
//login
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   

  @override
   final _formKey = GlobalKey<FormState>();
    final TextEditingController name = TextEditingController();
   final TextEditingController email=TextEditingController();
   final TextEditingController password=TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;
 final NameController nameController = Get.put(NameController());

  @override
  void dispose() {
    
    email.dispose();
    password.dispose();
    super.dispose();
  }
  //logic function
  Future<void> loginUser(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
     
    );
    print('user logged in');
     nameController.name.value = name.text;
    Get.to(Welcome());
  } catch (e) {
    debugPrint(e.toString());
    print(e.toString());
      Get.snackbar(
      'Login failed',
      'Incorrect email or password',
      duration: Duration(seconds: 3),
      backgroundColor: Color.fromARGB(255, 204, 135, 44),
      colorText: Colors.white,
    );
  }
   
}


  //////////
  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
          backgroundColor:Colors.white,
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(7.h),
        child: Form(
          key: _formKey,
          child: Column(
              children: [
                SizedBox(height:3.h),
                Center(child:
            Image(
            image: AssetImage('assets/img.png'),
            width: 70.w,
            height: 20.h,
          ),
        
        
                
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                
                Text( 'LogIn to your account 👩‍🍳',
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
                      height: 3.h,
                    ),
                      Formfields(text: 'Name', icon: Icons.person, controller: name,  
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },),
                      SizedBox(height:3.h ),

////email
Formfields(text: 'Email', icon: Icons.email, controller:email,validator: (value) {
                        if (value.isEmpty) {
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
                      } ,obscureText: true,),
               
        
         
          SizedBox(height:3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Don't have an account", textAlign: TextAlign.right,style: TextStyle(fontSize: 16.sp,color: Colors.black),),
          TextButton(onPressed: (){Get.to(Signup());}, child: Text("Sign up", textAlign: TextAlign.right,style: TextStyle(fontSize: 16.sp,color: Color.fromARGB(255, 204, 135, 44), fontWeight: FontWeight.bold),)),
            
          ],
        ),
        SizedBox(height: 2.h,),
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
                           var userEmail = email.text.trim();
    var userPassword = password.text.trim();
    await loginUser(userEmail, userPassword);
                          }
                        },
                        child: Text(
                          "LogIn",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                       
                        
                    ),)
                  )
                    ],
                  ),
                
                 
              ],
          ),
        ),
      ),
    ),
        );
     
   
  }
}

class Formfields extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function(String)? validator;
  final TextEditingController controller;
  final bool obscureText; // New parameter for password visibility

  const Formfields({
    Key? key,
    required this.text,
    required this.icon,
    this.validator,
    required this.controller,
    this.obscureText = false, // Default value is false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
     
      obscureText: obscureText, 
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: Colors.black),
        fillColor: Colors.white.withOpacity(0.2),
        filled: true,
        suffixIcon: Icon(icon, color: Colors.black.withOpacity(0.8)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 204, 135, 44)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 204, 135, 44)),
        ),
      ),
    );
  }
}






