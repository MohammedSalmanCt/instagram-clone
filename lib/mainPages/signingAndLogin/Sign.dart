import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sintask/Methods/Authentication.dart';
import 'package:sintask/mainPages/home.dart';
import 'Login.dart';
import '../../Old/home.dart';

var size, h, w;

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {

  FocusNode name1=FocusNode();
  FocusNode em=FocusNode();
  FocusNode ph1=FocusNode();
  FocusNode pass1=FocusNode();
  FocusNode con1=FocusNode();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController Ph = TextEditingController();
  TextEditingController passwrd = TextEditingController();
  TextEditingController Conpass = TextEditingController();

  Authentication _auth = Authentication();

  bool pass = true;
  bool conpass = true;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Container(
          height: h * (0.05),
          width: w,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  focusNode: name1,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(em);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "User Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.name,
                  controller:name,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      //allow upper and lower case alphabets and space
                      return "Enter Correct Name";
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  height: h * (0.02),
                ),
                TextFormField(
                  focusNode: em,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(ph1);
                  },
                  controller: email,
                  // keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                ),

                SizedBox(
                  height: h * (0.02),
                ),
                IntlPhoneField(
                  focusNode: ph1,
                  onSubmitted: (value){
                    FocusScope.of(context).requestFocus(pass1);
                  },
                  flagsButtonPadding: const EdgeInsets.all(8),
                  dropdownIconPosition: IconPosition.trailing,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  initialCountryCode: 'IN',
                ),

                SizedBox(
                  height: h * (0.02),
                ),
                TextFormField(
                  focusNode: pass1,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(con1);
                  },
                  controller: passwrd,
                  keyboardType: TextInputType.text,
                  obscureText: pass,
                  autofillHints: [AutofillHints.password],
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Password",
                    suffix: InkWell(
                      child:
                          Icon(pass ? Icons.visibility_off : Icons.visibility),
                      onTap: () {
                        setState(() {
                          pass = !pass;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if(value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value))
                  //   {
                  //     return 'Please Enter the Password';
                  //   }
                  //   else
                  //   {
                  //     return null;
                  //   }
                  // },
                ),
                SizedBox(
                  height: h * (0.02),
                ),
                TextFormField(
                  focusNode: con1,
                  controller: Conpass,
                  keyboardType: TextInputType.text,
                  obscureText: conpass,
                  autofillHints: [AutofillHints.password],
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "confirmation Password",
                    suffix: InkWell(
                      child: Icon(
                        conpass ? Icons.visibility_off : Icons.visibility,
                      ),
                      onTap: () {
                        setState(() {
                          conpass = !conpass;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if(conpass!=passwrd.text)
                  //     {
                  //       return "Please Enter your correct password";
                  //     }
                  // },
                ),
                SizedBox(
                  height: h * (0.05),
                ),
                ElevatedButton(
                  onPressed: () {
                    _auth.getuser( context, email, passwrd, name,
                        Ph, Conpass);

                    // if (Us.text != '' &&
                    //     email.text != '' &&
                    //     Ph.text != '' &&
                    //     passwrd.text != '' &&
                    //     conpass != '') {
                    //   if (passwrd.text == conpass) {
                    //     if (email.text.contains("@")) {
                    //       if (Ph.text.length == 10) {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => Home(),
                    //             ));
                    //       } else {
                    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //             content: Text("Please enter a valid number")));
                    //       }
                    //     } else {
                    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //           content: Text("Please enter a valid email")));
                    //     }
                    //   } else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(content: Text("Password doesn't match")));
                    //   }
                    // } else {
                    //   Us.text == ''
                    //       ? ScaffoldMessenger.of(context).showSnackBar(
                    //           SnackBar(content: Text("Enter full name")))
                    //       : email.text == ''
                    //           ? ScaffoldMessenger.of(context).showSnackBar(
                    //               SnackBar(content: Text("Enter Email")))
                    //           : Ph.text == ''
                    //               ? ScaffoldMessenger.of(context).showSnackBar(
                    //                   SnackBar(content: Text("Enter phone")))
                    //               : passwrd.text == ''
                    //                   ? ScaffoldMessenger.of(context)
                    //                       .showSnackBar(SnackBar(
                    //                           content: Text("Enter Password")))
                    //                   : ScaffoldMessenger.of(context)
                    //                       .showSnackBar(SnackBar(
                    //                           content:
                    //                               Text("Enter Repassword")));
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    minimumSize: Size(w, h * (0.07)),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text("Sign Up"),
                ),
                SizedBox(
                  height: h * (0.03),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Already have an account?"),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, MaterialPageRoute(
                          builder: (context) {
                            return Login();
                          },
                        ));
                      },
                      child: Container(
                        child: Text("Log in",
                            style: TextStyle(
                              color: Colors.green.shade500,
                              fontSize: h * (0.02),
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: h * (0.03),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "OR",
                      style: TextStyle(fontSize: h * (0.02)),
                    )
                  ],
                ),
                SizedBox(
                  height: h * (0.03),
                ),
                InkWell(
                  onTap: () {
                    _auth.signInWithGoogle().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        )));
                  },
                  child: Container(
                    height: h * (0.07),
                    width: w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("image/g1.png"),
                          height: h * (0.03),
                        ),
                        SizedBox(
                          width: w * (0.05),
                        ),
                        Text("Continue with Google",
                            style: TextStyle(
                              fontSize: h * (0.02),
                            )),
                      ],
                    ),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                  ),
                ) //   height: height *(0.07),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
