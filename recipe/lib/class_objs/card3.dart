
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class Card3 extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback tap;
  const Card3({Key? key, required this.text, required this.image, required this.tap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: double.infinity,
                height: 50.h,
                child: GestureDetector(
                  onTap: tap,
                  child: Card(
                    
                     shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(10.sp)
                    ),
                  
                 
                  child: Column(
                
                    children: <Widget>[
                      Image.asset(
                        image,
                        width: double.infinity,
                        height: 35.h,
                        fit: BoxFit.cover,
                      ),
                     
                     SizedBox(height: 4.h,),
                      Container(
                        height: 7.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp),bottomRight: Radius.circular(10.sp)),
                          color: Colors.transparent
                        ),
                      
                         child: Column(
                          children: [
                            Text(
                      text,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                         
                          color: Colors.black,
                        ),
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