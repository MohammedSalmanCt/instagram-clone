import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sintask/Methods/sharedpre.dart';
import 'package:sintask/mainPages/homepage/screen_Home.dart';
import 'package:sintask/mainPages/signingAndLogin/Login.dart';
import 'Methods/Authentication.dart';
import 'Old/home.dart';
import 'mainPages/AddPost/addPost.dart';
import 'mainPages/home.dart';
var usernow ;
var mytUser=FirebaseAuth.instance.currentUser!.uid;
Authentication _auth = Authentication();
// var currentUser;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb)
  {
     await Firebase.initializeApp(
      options:FirebaseOptions(
          apiKey: "AIzaSyAtK_BmTDg6qyJX0rcLFARDakxww3nR6ms",
          // authDomain: "adil-26a27.firebaseapp.com",
          projectId: "adil-26a27",
          // storageBucket: "adil-26a27.appspot.com",
          messagingSenderId: "299399344807",
          appId: "1:299399344807:web:d151c86bf785ff5beb6182",
          // measurementId: "G-HM8GY9XZDP"
      )
    );
  }
  else {
    await Firebase.initializeApp();
    }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  // bool aa=false;
  //  get2() async {
  //   final SharedPreferences prefs = await SharedPreferences
  //       .getInstance();
  //
  //    if(prefs.containsKey("name")){
  //      aa=true;
  //    }else{
  //      aa=false;
  //    }
  //    setState(() {
  //
  //    });
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   get2();
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            backgroundColor: Colors.white
          ),
        ),
      ),
      home:  HomePage(),
      debugShowCheckedModeBanner: false,
    );
 }
}

// const firebaseConfig = {
//   apiKey: "AIzaSyDuv_7dRPNfTSFHZqUeO0exLHdLWwNiD5g",
//   authDomain: "salman-2b79f.firebaseapp.com",
//   projectId: "salman-2b79f",
//   storageBucket: "salman-2b79f.appspot.com",
//   messagingSenderId: "306582137528",
//   appId: "1:306582137528:web:243c276721419f048de24d",
//   measurementId: "G-8FJMNWLJFJ"
// };


