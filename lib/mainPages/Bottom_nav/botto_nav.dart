import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sintask/Methods/sharedpre.dart';
import '../../Methods/Authentication.dart';
import '../../Constants/constants.dart';
import '../../main.dart';
import '../../modelClass/userModel.dart';

ValueNotifier<int> indexChangedNotifier = ValueNotifier(0);

class BottomNav extends StatefulWidget {
  BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  Authentication _auth = Authentication();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.getur();

  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangedNotifier,
      builder: (context, int newIndex, child) {
        return BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: newIndex,
            onTap: (index) {
              indexChangedNotifier.value = index;
            },
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            selectedIconTheme: IconThemeData(
              color: Colors.black,
            ),
            unselectedIconTheme: IconThemeData(color: Colors.black),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "gss"),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: "nskns"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined), label: "djxnzjxjcschd"),
              BottomNavigationBarItem(
                  icon: CircleAvatar(
                      backgroundImage: NetworkImage(model?.profile??"data:image/jpeg;base64,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"),
                      radius: 14),
                  label: 'hjgjjh'),
            ]);
      },
    );
  }
}
