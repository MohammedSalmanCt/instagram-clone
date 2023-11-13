import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sintask/mainPages/myprofile/myprofillePage.dart';
import '../mainPages/home.dart';

class FollowAppBar extends StatelessWidget {
  const FollowAppBar({super.key,required this.title1,required this.Icons});
  final String title1;
  final IconData Icons;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h= size.height;
    w = size.width;
    return Padding(
      padding:  EdgeInsets.only(top: h*(0.013),
          right: w*(0.03),
          left: w*(0.03)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context) => MyprofileMAin(),));
            },
            child: Icon(Icons,
                color: Colors.black),
          ),
          SizedBox(width: w*(0.05),),
          Text(title1, style: GoogleFonts.robotoSlab(
              fontSize: h*(0.03),
              fontWeight: FontWeight.w500
          ),),
        ],
      ),
    );
  }
}
