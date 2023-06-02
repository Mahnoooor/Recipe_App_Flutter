
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class Card2 extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback tap;
  const Card2({Key? key, required this.text, required this.image, required this.tap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: 42.w,
                child: GestureDetector(
                  onTap: tap,
                  child: Card(
                     shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(10.sp)
                    ),
                  
                  elevation: 4.0,
                  child: Column(
                
                    children: <Widget>[
                      Image.asset(
                        image,
                        height: 15.h,
                        fit: BoxFit.cover,
                      ),
                     
                     SizedBox(height: 2.h,),
                      Container(
                        height: 7.h,
                        width: 42.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp),bottomRight: Radius.circular(10.sp)),
                          color: Colors.white
                        ),
                      
                         child: Column(
                          children: [
                             Text(
                          text,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              
                          ],
                         )
                       
                      ),
                   
                    ],
                  ),
                ),
                ),
              );
  }
}