
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class Card1 extends StatelessWidget {
  final String text;
  final String text2;
  final String image;
  final VoidCallback tap;
  const Card1({Key? key, required this.text, required this.image, required this.text2, required this.tap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: 80.w,
                child: InkWell(
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
                        width: 80.w,
                        height: 20.h,
                        fit: BoxFit.cover,
                      ),
                     
                     SizedBox(height: 2.h,),
                      Container(
                        height: 10.h,
                        width: 80.w,
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
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                SizedBox(height: 2.h,),
                         Text(
                          text2,
                          style: TextStyle(
                            fontSize: 18.sp,
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