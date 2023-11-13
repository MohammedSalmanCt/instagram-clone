import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sintask/mainPages/signingAndLogin/Login.dart';
import '../../../modelClass/userModel.dart';



class drawerpr extends StatefulWidget {
  const drawerpr({super.key});

  @override
  State<drawerpr> createState() => _drawerprState();
}

class _drawerprState extends State<drawerpr> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: h * (0.8),
              width: w,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: h*(0.2)),
                  ListTile(
                    leading: Icon(Icons.settings,
                    color: Colors.black),
                    title: Text("Settings"),
                  ),  ListTile(
                    leading: Icon(CupertinoIcons.bookmark,
                    color: Colors.black),
                    title: Text("Saved"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 360),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          height: h * (0.07), width: w / 2),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              textStyle: TextStyle(
                                  fontSize: w / 23,
                                  fontWeight: FontWeight.w800)),
                          child: Text("Log Out"),
                          onPressed: () async {
                            SharedPreferences pref=await SharedPreferences.getInstance();
                            pref.remove('uid');
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>Login(),), (route) => false);
                          }),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

