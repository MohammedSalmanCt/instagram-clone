import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sintask/Constants/Constants.dart';
import 'package:sintask/customWidgegts/appbar_widget.dart';
import 'package:sintask/main.dart';
import 'package:sintask/mainPages/myprofile/EditProfile/Editpro.dart';
import 'package:sintask/mainPages/myprofile/followers.dart';
import 'package:sintask/mainPages/myprofile/following.dart';
import 'package:sintask/mainPages/myprofile/stream.dart';
import 'package:sintask/modelClass/userModel.dart';
import '../../Methods/Authentication.dart';
import '../home.dart';
import 'Drawer/drawer.dart';

class MyprofileMAin extends StatefulWidget {
  const MyprofileMAin({super.key});

  @override
  State<MyprofileMAin> createState() => _MyprofileMAinState();
}

class _MyprofileMAinState extends State<MyprofileMAin> {
  Authentication _auth = Authentication();
  int allfollowingflength=0;
  int allmyposts=0;
  getfollowing() async {
    var myfolloowing= await FirebaseFirestore.instance
        .collection(Constants.firebasecollections)
        .where('followers',arrayContains: mytUser);
    AggregateQuerySnapshot followingLength=await myfolloowing.count().get();
    allfollowingflength = followingLength.count;
    setState(() {

    });
  }

  getPosts() async {
    var myPosts= await FirebaseFirestore.instance
        .collection(Constants.firebasecollections)
        .doc(mytUser).collection('posts');
    AggregateQuerySnapshot postslength=await myPosts.count().get();
    allmyposts= postslength.count;
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfollowing();
    // getPosts();

    _auth.getur();
    print(model?.id);
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        endDrawer: drawerpr(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('model!.name??fgh',style: GoogleFonts.kanit(
              color: Colors.black,
              fontSize: h*(0.025),
              fontWeight: FontWeight.w500
          )),
          actions: [
            Icon(Icons.add_box_outlined,
              color: Colors.black,
            ),
            SizedBox(width: w*(0.05),),
          Builder(builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Icon(Icons.menu,
                color: Colors.black,));
          }),
            SizedBox(width: w*(0.03),),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(w*(0.04),h*(0.03),w*(0.03),h*(0.02)),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:NetworkImage('model!.profile??'),
                  radius: 42,),
                  Spacer(),
                  Column(
                     children: [
                       Text(allmyposts.toString(),style:TextStyle(
                         fontWeight: FontWeight.w700,
                         fontSize: h*(0.025)
                       ) ),
                       Text("Posts",
                           style: TextStyle(
                               fontSize: h*(0.02)
                           )),
                     ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FollowerA(),));
                    },
                    child: Column(
                       children: [
                         Text("model!.followers.length.toString()",style:TextStyle(
                           fontWeight: FontWeight.w700,
                           fontSize: h*(0.025)
                         ) ),
                         Text("Followers",
                             style: TextStyle(
                                 fontSize: h*(0.02)
                             )),
                       ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FollowingA(),));
                    },
                    child: Column(
                       children: [
                         Text(allfollowingflength.toString(),style:TextStyle(
                           fontWeight: FontWeight.w700,
                           fontSize: h*(0.025)
                         ) ),
                         Text("Following",
                         style: TextStyle(
                           fontSize: h*(0.02)
                         )),
                       ],
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(
              width: w*(0.90),
              child: Container(
                height: h*(0.05),
                width: w,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("!model!.name",style: TextStyle(
                          fontWeight: FontWeight.w600
                        ),),
                      ],
                    ),
                    SizedBox(height: h*(0.005),),
                    Row(
                      children: [
                        Text("Public figure",
                        style: TextStyle(
                          color: Colors.grey
                        ),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: h*(0.005),),
            SizedBox(
              width: w*(0.94),
              child: Container(
                height: h*(0.065),
                width: w,
                child: Center(
                  child: Text("Professional dashboard",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  )),
                ),
                decoration: BoxDecoration(
                    color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            SizedBox(height: h*(0.01),),
            Row(
              children: [
                SizedBox(width: w*(0.026),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditPro(),));
                  },
                  child: Container(
                    height: h*(0.04),
                    width: w*(0.465),
                    child: Center(
                      child: Text("Edit Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: h*(0.02)
                          )),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  height: h*(0.04),
                  width: w*(0.465),
                  child: Center(
                    child: Text("Share Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: h*(0.02)
                        )),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(width: w*(0.026),),
              ],
            ),
            SizedBox(height: h*(0.025),),
            Expanded(
              child: Container(
                height: h * 0.5,
                child: Column(
                  children: [
                    TabBar(
                      unselectedLabelColor: Colors.black38,
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Container(
                            height: h * 0.09,
                            width: w * 0.5,
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.perm_media_outlined, size: h * 0.04),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: h * 0.09,
                            width: w * 0.5,
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.person_pin_outlined, size: h * 0.04),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Streamb(),
                          Container(
                            height: h * 0.6,
                            width: w,
                            color: Colors.cyan,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
