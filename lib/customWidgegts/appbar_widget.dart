import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../mainPages/home.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key,required this.title,required this.Icons,required this.Icons2});
  final String title;
  final IconData Icons;
  final IconData Icons2;

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
          Text(title, style: GoogleFonts.lobster(
              fontSize: h*(0.03),
              fontWeight: FontWeight.w500
          ),),
          Spacer(),
          Icon(Icons,
              color: Colors.black),
          SizedBox(width: w*(0.05),),
          Icon(Icons2,
              color: Colors.black),
        ],
      ),
    );
  }
}
