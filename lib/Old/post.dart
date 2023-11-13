import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Methods/Authentication.dart';
import '../mainPages/signingAndLogin/Login.dart';
import '../Constants/constants.dart';
import 'home.dart';
import '../main.dart';
import '../modelClass/userModel.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {

  Stream<QuerySnapshot<Map<String, dynamic>>> myPost() {
    return FirebaseFirestore.instance
        .collection(Constants.firebasecollections)
       .doc(mytUser).collection("posts").snapshots();
  }

  Authentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
          actions: [
            GestureDetector(
              onTap: () {
                  showModalBottomSheet(
                    context: context, builder: ( BuildContext context) {
                    return Container(
                      width: w,
                      height: h*(0.3),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                              // _auth.postCamera();
                              Navigator.pop(context, MaterialPageRoute(builder: (context) => Post(),));
                            },
                          ),
                          GestureDetector(
                            child: ListTile(
                              leading: Icon(
                                  Icons.perm_media_outlined
                              ),
                              title: Text("Gallary"),
                            ),
                            onTap: ()  {
                              // _auth.media();
                              // Navigator.pop(context, MaterialPageRoute(builder: (context) => EditPro(),));

                            },
                          )
                        ],
                      ),
                    );
                  },
                  );
              },
              child: Column(
                children: [
                  SizedBox(height: h*(0.005),),
                  Icon(Icons.add_circle_outline),
                  SizedBox(height: h*(0.005),),
                  Text("Add Post"),
                ],
              ),
            ),
            SizedBox(width: w*(0.03),)
          ],
        ),
        body: Column(
          children: [
    StreamBuilder(
    stream: myPost(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  width: w,
                  height: h * (0.4),
                  // child: Image(
                  //   image: AssetImage(),
                  color: Colors.yellow
                  ),
              );
            },
          ),
        );
    }
      return Container();
    }
    ),
          ],
        ),
      ),
    );
  }
}
