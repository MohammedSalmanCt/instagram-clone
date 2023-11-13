import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Methods/Authentication.dart';
import 'customWidgegts/followerAppbar.dart';
import 'mainPages/home.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Authentication _auth=Authentication();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: FollowAppBar(
            Icons: Icons.arrow_back,
            title1: "Add Post"),
      ),
      body: Column(
        children: [
          SizedBox(height: h*(0.07),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: h*(0.4),
                width: w*(0.7),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue,
                        width: 2)
                ),
                child: Icon(Icons.add,
                  size: h*(0.06),
                  color: Colors.blue,),
              ),
            ],
          ),
          SizedBox(height: h*(0.05),),

    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: h*(0.1),width: w*(0.7),
          child: TextFormField(
          decoration: InputDecoration(
          hintText: "Email",
          border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue)),
          ),
          ),
          ),
      ],
    ),

          ElevatedButton(onPressed: () {

          }, child: Text("Add")),
        ],
      ),
    );
  }
}
