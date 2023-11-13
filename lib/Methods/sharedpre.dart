import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sintask/mainPages/signingAndLogin/Login.dart';
import 'package:sintask/mainPages/home.dart';
import '../Constants/Constants.dart';
import '../Old/home.dart';
import '../main.dart';
import '../modelClass/userModel.dart';
import 'Authentication.dart';

class Sp extends StatefulWidget {
  const Sp({super.key});

  @override
  State<Sp> createState() => _SpState();
}

class _SpState extends State<Sp> {
  Authentication _auth = Authentication();

  // localStatus(){
  //   SharedPreferences.getInstance().then((pref) async {
  //     print("ascasssssssss");
  //     print(model?.id);
  //     print(model?.name);
  //     print(mytUser);
  //     if(pref.containsKey('uid')) {
  //       print(model?.id);
  //       print("aaaaaaaaaaaa");
  //       print(mytUser);
  //       mytUser = pref.getString('uid')!;
  //       DocumentSnapshot userSnapshot=await FirebaseFirestore.instance.collection(Constants.firebasecollections)
  //           .doc(mytUser).get();
  //         if (userSnapshot.exists) {
  //         userModel model = userModel.fromMap(userSnapshot.data() as Map<String,dynamic>);
  //           print("xxxxxxxxxxxxxxxxxxxxxxxxx");
  //         print(model?.id);
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (context) => HomePage()),
  //                 (route) => false,
  //           );
  //         }
  //         else {
  //           Navigator.pushAndRemoveUntil(
  //               context, MaterialPageRoute(builder: (context) => Login(),), (
  //               route) => false);
  //           print("mmsxmxmmxmmmmxm");
  //           print(model?.id);
  //           print(mytUser);
  //         }
  //         if (mounted) {
  //           setState(() {
  //             if (model != null) {
  //             }
  //           });
  //         }
  //     }
  //     else{
  //       print("wwwwwwwwwwwwwwwwwwwwww");
  //      return  Container(
  //         height: 100,
  //         width: 100,
  //         color: Colors.red,
  //       );
  //     }
  //   });
  // }
  localStatus(){
    SharedPreferences.getInstance().then((pref) {
      print("ascasssssssss");
      if(pref.containsKey('uid')){
        print("sssssssss");

        mytUser=pref.getString('uid')!;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);

      }
      else{
        print("vvvvvvvvvvv");
        print(model?.id);
        print(model?.name);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false);
      }
    });
  }
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),(){
      _auth.getur();
      print(model?.name);
      localStatus();

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ) ;
  }
}
