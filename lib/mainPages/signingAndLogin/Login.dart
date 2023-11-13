import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sintask/Methods/Authentication.dart';
import 'package:sintask/mainPages/signingAndLogin/Sign.dart';
import 'package:sintask/Old/home.dart';
import 'package:sintask/mainPages/home.dart';
var size, h, w;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  FocusNode email1=FocusNode();
  FocusNode paas1=FocusNode();


  // @override
  // void initState() {
  //   sal();
  //   // TODO: implement initState
  //   super.initState();
  // }
  bool pass = true;
  TextEditingController email = TextEditingController();
  TextEditingController passwrd = TextEditingController();
  Authentication _auth=Authentication();
  // sal(){
  //   FirebaseFirestore.instance.collection('settings').doc('salman').update({
  //     "test.name":FieldValue.delete()
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: h * (0.02),
              ),
              TextFormField(
                focusNode: email1,

                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(paas1);
                },
                // validator: (value) {
                //   if(value == null || value.trim().isEmpty)
                //     {
                //       return 'enter the email';
                //     }
                //   if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))
                //     {
                //       return 'Please Enter the valid Email';
                //     }
                //     else
                //       {
                //         return null;
                //       }
                // },
              ),

              SizedBox(
                height: h * (0.02),
              ),
              TextFormField(
                focusNode: paas1,
                // onSaved: (text)
                // {
                //   print(text);
                // },
                controller: passwrd,
                obscureText: pass,
                autofillHints: [AutofillHints.password],
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: "Password",
                  suffix: InkWell(
                    child: Icon(pass ? Icons.visibility_off : Icons.visibility),
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
              SizedBox(height: h*(0.03),),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                },
                child: Text("Forgot Password",style:
                TextStyle(
                  color: Colors.blue,
                  fontSize: h * (0.02),
                )),
              ),
              SizedBox(
                height: h * (0.05),
              ),
              ElevatedButton(
                onPressed: () {
                  if(email.text!="" && passwrd.text !="") {
                    _auth.getusrr(email, passwrd,context);
                  }
                  else if(email.text=="")
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("invalid email")));
                        }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(" invalid password ")));
                    }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  minimumSize: Size(w, h * (0.07)),
                  backgroundColor: Colors.blue,
                ),
                child: Text("Log In"),
              ),
              SizedBox(
                height: h * (0.03),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have any account?"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Sign();
                        },
                      ));
                    },
                    child: Container(
                      child: Text("Sign Up",
                          style: TextStyle(
                            color: Colors.green.shade500,
                            fontSize: h * (0.02),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: h * (0.05),
              ),
              InkWell(
                onTap: () {
                 _auth.signInWithGoogle().then((value) =>
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false));
                },
                child: Container(
                  height: h * (0.07),
                  width: w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("image/g1.png"),
                        height: h * (0.04),
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
              ) //   height: h
            ],
          ),
        ),
      ),
    ));
  }
}
