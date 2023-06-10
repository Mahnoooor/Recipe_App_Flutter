import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../class_objs/drawer.dart';
import 'Feed.dart';


class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
   final _formKey = GlobalKey<FormState>();
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   final TextEditingController name=TextEditingController();
   final TextEditingController name2=TextEditingController();
  String imageurl='';

   CollectionReference _reference =
      FirebaseFirestore.instance.collection('posts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(),
      // backgroundColor: Color.fromARGB(148, 25, 51, 73),
    
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:7.w,vertical: 5.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
              
                children: [
                  Row(children: [
                     IconButton(
                      icon: Icon(Icons.menu_rounded, size: 25.sp),
                      onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                        },
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
Center(child: Text('HOME', style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:22.sp)))
                  ],),

                  SizedBox(
                    height: 3.h,
                  ),
                  Text('Share your experience:', style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:18.sp)),
                  SizedBox(height: 3.5.h,),
                      TextFormField(
                          controller: name,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle:TextStyle(color:Colors.black),
                    // fillColor: Color.fromRGBO(255, 255, 255, 0.1), 
                   filled: true,
                   suffixIcon: Icon(Icons.draw_outlined,color:  Colors.black.withOpacity(0.8)),
               //TextStyle(fontSize: 20.0, color:Colors.white),
                   focusedBorder:  OutlineInputBorder(
              borderSide:
                    BorderSide(width: 2.sp, color: Color.fromRGBO(217, 150, 81, 1)), 
              borderRadius: BorderRadius.circular(15.sp),
                   ),
                    enabledBorder: OutlineInputBorder(
              borderSide:
                    BorderSide(width: 1.sp, color:Color.fromRGBO(217, 150, 81, 1)), 
              borderRadius: BorderRadius.circular(15.sp),
                   )
                  ),
                         
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      /////////////
SizedBox(height: 2.h,),
                   TextFormField(
                          controller: name2,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                    hintText: 'Caption',
                    hintStyle:TextStyle(color:Colors.black),
                    // fillColor: Color.fromRGBO(255, 255, 255, 0.1), 
                   filled: true,
                   suffixIcon: Icon(Icons.draw_outlined,color:  Colors.black.withOpacity(0.8)),
               //TextStyle(fontSize: 20.0, color:Colors.white),
                   focusedBorder:  OutlineInputBorder(
              borderSide:
                    BorderSide(width: 2.sp, color: Color.fromRGBO(217, 150, 81, 1)), 
              borderRadius: BorderRadius.circular(15.sp),
                   ),
                    enabledBorder: OutlineInputBorder(
              borderSide:
                    BorderSide(width: 1.sp, color:Color.fromRGBO(217, 150, 81, 1)), 
              borderRadius: BorderRadius.circular(15.sp),
                   )
                  ),
                         
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),     
////////
                        SizedBox(
                          height: 3.h,
                        ),
            Row(
              children: [
IconButton(onPressed: () async {
                                 ImagePicker imagePicker=ImagePicker();
                                 XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
                                 print('${file?.path}');
                String uniqueFileName=DateTime.now().millisecondsSinceEpoch.toString();
                                 //
                                 Reference referenceRoot=FirebaseStorage.instance.ref();
                                 Reference referenceDirImages=referenceRoot.child('images');//this will create directory of images in storage of firebase
                 
                                 // now to upload the file creating ref of image to be stored
                                 Reference referenceImageToUpload=referenceDirImages.child(uniqueFileName);
                try{
                                   //upload/store image
                await referenceImageToUpload.putFile(File(file!.path));
                imageurl=await referenceImageToUpload.getDownloadURL();
                }
                catch(e){print(e.toString());}}, icon: Icon(Icons.add, color: Color.fromRGBO(217, 150, 81, 1),size: 25.sp,)),
//////////////////////////
SizedBox(width: 2.w,),

Padding(
                            padding:  EdgeInsets.only(left:0.w),
                            child: GestureDetector(
                              onTap: (){},
                              child: Container(
                              width: 28.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp),
                                color:  Color.fromRGBO(217, 150, 81, 1), 
                              ),
                              child: TextButton(
                                   onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (imageurl.isEmpty) {
                                  // Show an error message if the image has not been uploaded
                                  Get.snackbar(
                                    'Upload failed',
                                    'Please select an image',
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                } else {
                                  Map<String, dynamic> dataToSend = {
                                    'name': name.text,
                              
                                    'image': imageurl,
                                    'caption' : name2.text,
                                  };
                                                    
                                  // Save the Map to the "post" document with document id "postId" in the "posts" collection
                                  _reference.add(dataToSend);
                                                    
                                  // Show a success message
                                  Get.snackbar(
                                    'Upload successful',
                                    'Your post has been uploaded',
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );
                                                    
                                  // Clear the form and image URL
                                  _formKey.currentState!.reset();
                                  name.clear();
                                  setState(() {
                                    imageurl = '';
                                  });
                                  
                                }
                              }
                                                    },
                                                    
                                                    
                                        //           
                                child: Text(
                                  "POST",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                               
                                
                                                  ),)
                                                ),
                            ),
                          ),


              ],
            ),
                        
                       
            
            
                      
                      SizedBox(height: 2.h,),
                      /////////upload container
                      ///
                          
            
                     
                ],
              ),
            ),
          ),
        ),
         
      ),
    
    );
  }
}