import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sintask/Methods/Authentication.dart';
import 'package:sintask/Old/home.dart';
import '../../../main.dart';
import '../../../modelClass/userModel.dart';
import '../../home.dart';

class EditPro extends StatefulWidget {
  const EditPro({super.key});

  @override
  State<EditPro> createState() => _EditProState();
}

class _EditProState extends State<EditPro> {
  final _formKey = GlobalKey();
  TextEditingController _name = TextEditingController(text: model?.name ?? '');
  TextEditingController _phone =
      TextEditingController(text: model?.phone ?? "");
  Authentication _auth = Authentication();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _auth.getModel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: model == null
            ? CircularProgressIndicator()
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ));
                    },
                    child: Icon(
                      Icons.close,
                      size: h * (0.04),
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () async {
                        model = await _auth.loginuser(mytUser);
                        var edtprof = model?.copyWith(
                            name: _name.text, phone: _phone.text);
                        model?.reference!.update(edtprof!.toMap());
                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.done,
                          color: Colors.blue, size: h * (0.04)),
                    ),
                    SizedBox(
                      width: w * (0.05),
                    ),
                  ],
                ),
                body: ListView(children: [
                  SizedBox(
                    height: h * (0.05),
                  ),
                  Column(
                    children: [
                      Center(
                        child: GestureDetector(
                          child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(model!.profile!),
                                  radius: 50),
                              SizedBox(
                                height: h * (0.015),
                              ),
                              Text("Edit Picture",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20)),
                            ],
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  width: w,
                                  height: h * (0.3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // borderRadius: BorderRadius.only(
                                    //   topRight: Radius.circular(50),
                                    //   topLeft: Radius.circular(50),
                                    // )
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.camera_alt_outlined,
                                          ),
                                          title: Text("Camera"),
                                        ),
                                        onTap: () {
                                          _auth.camera();
                                          Navigator.pop(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditPro(),
                                              ));
                                        },
                                      ),
                                      GestureDetector(
                                        child: ListTile(
                                          leading:
                                              Icon(Icons.perm_media_outlined),
                                          title: Text("Gallary"),
                                        ),
                                        onTap: () {
                                          _auth.media();
                                          Navigator.pop(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditPro(),
                                              ));
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: h * (0.06),
                      ),
                      Form(
                        key: _formKey,
                        child: SizedBox(
                          width: w * (0.9),
                          child: TextFormField(
                            controller: _name,
                            onChanged: (_name) {},
                            decoration: InputDecoration(
                              label: Text("Name"),
                            ),
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
                        ),
                      ),
                      SizedBox(
                        height: h * (0.02),
                      ),
                      SizedBox(
                        width: w * (0.9),
                        child: IntlPhoneField(
                          controller: _phone,
                          onChanged: (_phone) {},
                          flagsButtonPadding: const EdgeInsets.all(8),
                          dropdownIconPosition: IconPosition.trailing,
                          decoration:
                              InputDecoration(label: Text("Phone Number")),
                          initialCountryCode: 'IN',
                        ),
                      ),
                    ],
                  ),
                ]),
              ));
  }
}
