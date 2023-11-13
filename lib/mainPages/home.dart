import 'package:flutter/material.dart';
import 'package:sintask/mainPages/Bottom_nav/botto_nav.dart';
import 'package:sintask/mainPages/userpage/usermainPage.dart';
import '../AddImage.dart';
import 'AddPost/addPost.dart';
import 'homepage/screen_Home.dart';
import 'myprofile/myprofillePage.dart';
var size,h,w;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pages=[
    ScreenHome(),
    UserMain(),
    AddImage(),
    MyprofileMAin()
  ];


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h= size.height;
    w = size.width;
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
        valueListenable: indexChangedNotifier,
          builder: (context, int index, child) {
            return _pages[index];
          },
        ),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }
}
