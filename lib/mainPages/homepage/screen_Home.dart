import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sintask/Animation/likeAnimate.dart';
import 'package:sintask/Constants/Constants.dart';
import 'package:sintask/customWidgegts/appbar_widget.dart';
import 'package:sintask/customWidgegts/circleavatarStory.dart';
import 'package:sintask/main.dart';
import 'package:sintask/mainPages/homepage/homepost.dart';
import 'package:sintask/modelClass/commentModel.dart';
import '../../Methods/Authentication.dart';
import '../../modelClass/userModel.dart';
import '../../modelClass/postModel.dart';
import '../home.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {

  Authentication _auth = Authentication();

  // listenMethod() {
  //   FirebaseFirestore.instance
  //       .collection(Constants.firebasecollections)
  //       .doc(mytUser).snapshots()
  //       .listen(
  //         (value) {
  //       model = userModel.fromMap(value.data()!);
  //       if (mounted) {
  //         setState(() {});
  //       }
  //     },
  //   );
  // }

  Stream<List<PostClass>> allPost() {
    return FirebaseFirestore.instance.collectionGroup("posts").snapshots().map(
            (event) => event.docs.map((e) => PostClass.fromMap(e.data())).toList());
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // listenMethod();
    _auth.getur();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // listenMethod();

  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Scaffold(
      body: NestedScrollView(
         headerSliverBuilder: (context, innerBoxIsScrolled) {
           return [
             SliverAppBar(
               backgroundColor: Colors.white,
               pinned: false,
               floating: true,
               snap: true,
               title: Text("Instagram",style: GoogleFonts.lobster(
                 color: Colors.black,
                   fontSize: h*(0.03),
                   fontWeight: FontWeight.w500
               )),
               actions: [
                 Icon(Icons.favorite_border,
                 color: Colors.black,
                 ),
                 SizedBox(width: w*(0.05),),
                 Icon(CupertinoIcons.paperplane,
                 color: Colors.black,),
                 SizedBox(width: w*(0.04),),
               ],
             ),
             SliverToBoxAdapter(
               child:  Row(
                       children: [
                         SizedBox(
                           width: w * (0.025),
                         ),
                         Stack(children: [
                           Positioned(
                             child: CircleAvatar(
                             backgroundImage: NetworkImage("model!.profile"),
                               // backgroundColor: Colors.red,
                               radius: 38,
                             ),
                           ),
                           Positioned(
                               top: h * (0.064),
                               left: w * (0.13),
                               child: CircleAvatar(
                                 radius: 12,
                                 backgroundColor: Colors.blue,
                                 child: Icon(
                                   Icons.add,
                                   color: Colors.white,
                                   size: h * (0.025),
                                 ),
                               )),
                         ]),
                         SizedBox(
                           width: w * (0.04),
                         ),
                         Expanded(
                           child: Container(
                             height: 100,
                             child: ListView.separated(
                               itemCount: 16,
                               separatorBuilder: (BuildContext context, int index) {
                                 return SizedBox(
                                   width: 10,
                                 );
                               },
                               itemBuilder: (_, i) => Storyavtr(),
                               scrollDirection: Axis.horizontal,
                               physics: NeverScrollableScrollPhysics(),
                               shrinkWrap: true,
                             ),
                           ),
                         ),
                       ]
             )
             ),
           ];
         },
        body:  StreamBuilder(
            stream: allPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                return Container(
                  height: h * (0.7),
                  child: ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<userModel>(
                          stream: FirebaseFirestore.instance
                              .collection(Constants.firebasecollections)
                              .doc(data[index].id)
                              .snapshots()
                              .map((event) =>
                              userModel.fromMap(event.data()!)),
                          builder: (context, snapshot) {
                            userModel? usersPost = snapshot.data;
                            return HomePost(data: data, index: index,);                          });
                    },
                  ),
                );
              }
              return Container();
            }),
      ),
    );
  }
}
