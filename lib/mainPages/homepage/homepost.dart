import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Animation/likeAnimate.dart';
import '../../Constants/Constants.dart';
import '../../Methods/Authentication.dart';
import '../../main.dart';
import '../../modelClass/commentModel.dart';
import '../../modelClass/postModel.dart';
import '../../modelClass/userModel.dart';
import '../home.dart';

class HomePost extends StatefulWidget {
  List<PostClass> data;
  int index;
  HomePost({super.key, required this.data, required this.index});

  @override
  State<HomePost> createState() => _HomePostState();
}

class _HomePostState extends State<HomePost> {
  Authentication _auth = Authentication();
  TextEditingController _comment = TextEditingController();
  
  bool like = false;

  Stream<List<PostClass>> allPost() {
    return FirebaseFirestore.instance
        .collectionGroup("posts")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PostClass.fromMap(
                  doc.data(),
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return StreamBuilder<List<PostClass>>(
        stream: allPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PostClass> data = snapshot.data!;
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(Constants.firebasecollections)
                  .doc(widget.data[widget.index].id)
                  .snapshots()
                  .map((event) =>
                  userModel.fromMap(event.data()!)),
              builder: (context, snapshot) {
                userModel? usersPost = snapshot.data;
                if(!snapshot.hasData)
                  {
                    return CircularProgressIndicator();
                  }
              return  Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        w * (0.02), h * (0.01), w * (0.02), h * (0.01)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(usersPost!.profile??""),
                          radius: 16,
                        ),
                        SizedBox(
                          width: w * (0.04),
                        ),
                        Text(usersPost.name??"",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Spacer(),
                        Icon(Icons.more_vert),
                      ],
                    ),
                  ),
                  InkWell(
                    // onDoubleTap: () async {
                    //   if (widget.data[widget.index]
                    //       .likes
                    //       .contains(mytUser)) {
                    //     FirebaseFirestore.instance
                    //         .collection(Constants
                    //         .firebasecollections)
                    //         .doc(model!.id)
                    //         .collection("posts")
                    //         .doc(widget.data[widget.index].postId)
                    //         .update({
                    //       "likes": FieldValue.arrayRemove(
                    //           [mytUser])
                    //     });
                    //     setState(() {
                    //       like = false;
                    //     });
                    //   } else {
                    //     FirebaseFirestore.instance
                    //         .collection(Constants
                    //         .firebasecollections)
                    //         .doc(model!.id)
                    //         .collection("posts")
                    //         .doc(widget.data[widget.index].postId)
                    //         .update({
                    //       "likes": FieldValue.arrayUnion(
                    //           [mytUser])
                    //     });
                    //     setState(() {
                    //       like = true;
                    //     });
                    //   }
                    // },
                    child: Stack(
                      children: [
                        Container(
                          child: Image.network(widget.data[widget.index].post!,
                              fit: BoxFit.cover),
                          width: w,
                          height: h * (0.5),
                        ),
                        if (like)
                          Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: LikeIcon(
                                  like: like,
                                ),
                              )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        w * (0.02), h * (0.01), w * (0.02), h * (0.01)),
                    child: Row(
                      children: [
                        GestureDetector(
                          child:
                          // widget.data[widget.index].likes.contains(mytUser)
                          //     ? Icon(
                          //   Icons.favorite,
                          //   color: Colors.red,
                          // )
                          //     :
                          Icon(
                            Icons.favorite_border,
                          ),
                          // onTap: () async {
                          //   if (widget.data[widget.index].likes
                          //       .contains(mytUser)) {
                          //     FirebaseFirestore.instance
                          //         .collection(Constants.firebasecollections)
                          //         .doc(model!.id)
                          //         .collection("posts")
                          //         .doc(widget.data[widget.index].postId)
                          //         .update({
                          //       "likes": FieldValue.arrayRemove([mytUser])
                          //     });
                          //   } else {
                          //     FirebaseFirestore.instance
                          //         .collection(Constants.firebasecollections)
                          //         .doc(model!.id)
                          //         .collection("posts")
                          //         .doc(widget.data[widget.index].postId)
                          //         .update({
                          //       "likes": FieldValue.arrayUnion([mytUser])
                          //     });
                          //   }
                          // },
                        ),
                        SizedBox(
                          width: w * (0.05),
                        ),
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                                enableDrag: true,
                                showDragHandle: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    width: w,
                                    height: h * (0.9),
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Text("Comments",
                                            style: TextStyle(
                                                fontSize: h * (0.02),
                                                fontWeight: FontWeight.w500)),
                                        Divider(
                                          color: Colors.black,
                                          thickness: 1,
                                        ),
                                        StreamBuilder(
                                          stream: model!.reference!
                                              .collection("posts")
                                              .doc(widget
                                              .data[widget.index].postId)
                                              .collection("comments")
                                              .snapshots()
                                              .map((event) => event.docs
                                              .map((e) =>
                                              CommentClass.fromMap(
                                                  e.data()))
                                              .toList()),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<CommentClass>? usercomment =
                                              snapshot.data
                                              as List<CommentClass>?;
                                              return Expanded(
                                                child: Container(
                                                  height: h * (0.8),
                                                  child: ListView.builder(
                                                    itemCount:
                                                    usercomment!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return StreamBuilder(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection(Constants
                                                            .firebasecollections)
                                                            .where("id",
                                                            isEqualTo:
                                                            usercomment[
                                                            index]
                                                                .id)
                                                            .snapshots()
                                                            .map((event) => event
                                                            .docs
                                                            .map((e) => userModel
                                                            .fromMap(
                                                            e.data()))
                                                            .toList()),
                                                        builder:
                                                            (context, snapshot) {
                                                          List<userModel>? cpro = snapshot.data;
                                                          return Container(
                                                            height: h * (0.1),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                  w * (0.03),
                                                                ),
                                                                CircleAvatar(
                                                                  backgroundImage:
                                                                  NetworkImage(
                                                                      cpro?[0].profile ??
                                                                          ""),
                                                                  radius: 20,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  w * (0.04),
                                                                ),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(cpro?[0]
                                                                        .name ??
                                                                        ""),
                                                                    SizedBox(
                                                                      height: h *
                                                                          (0.005),
                                                                    ),
                                                                    Text(usercomment[
                                                                    index]
                                                                        .comment ??
                                                                        ""),
                                                                    SizedBox(
                                                                      height: h *
                                                                          (0.005),
                                                                    ),
                                                                    Text("Reply",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            color:
                                                                            Colors.black54)),
                                                                  ],
                                                                ),
                                                                Spacer(),
                                                                Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: Colors
                                                                        .black54),
                                                                SizedBox(
                                                                  width:
                                                                  w * (0.04),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            }
                                            return Container();
                                          },
                                        ),
                                        Divider(
                                          color: Colors.black87,
                                          thickness: 0.5,
                                        ),
                                        Padding(
                                          padding:
                                          MediaQuery.of(context).viewInsets,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: w * (0.03),
                                              ),
                                              CircleAvatar(
                                                backgroundImage:
                                                NetworkImage(model!.profile!),
                                                radius: 20,
                                              ),
                                              SizedBox(
                                                width: w * (0.04),
                                              ),
                                              SizedBox(
                                                child: TextFormField(
                                                  controller: _comment,
                                                  onFieldSubmitted: (_comment) {},
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Add Comments"),
                                                ),
                                                width: w * (0.65),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    CommentClass commentobj =
                                                    CommentClass(
                                                        id: mytUser,
                                                        commentId: "",
                                                        comment:
                                                        _comment.text,
                                                        commentDate:
                                                        Timestamp.now());
                                                    model!.reference!
                                                        .collection("posts")
                                                        .doc(widget
                                                        .data[widget.index]
                                                        .postId)
                                                        .collection("comments")
                                                        .add(commentobj.toMap())
                                                        .then((value) async {
                                                      print(value);
                                                      cmodel = await _auth
                                                          .getComment(
                                                          widget
                                                              .data[widget
                                                              .index]
                                                              .id ??
                                                              "",
                                                          widget
                                                              .data[widget
                                                              .index]
                                                              .postId
                                                              .toString(),
                                                          value.id);
                                                      var a = cmodel?.copyWith(
                                                          commentId: value.id);
                                                      value.update(a!.toMap());
                                                    });
                                                    _comment.clear();
                                                  },
                                                  child: Text(
                                                    "Post",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(CupertinoIcons.chat_bubble)),
                        SizedBox(
                          width: w * (0.05),
                        ),
                        Icon(CupertinoIcons.paperplane),
                        Spacer(),
                        InkWell(
                            onTap: () {
                              if (model!.saved
                                  .contains(widget.data[widget.index].postId)) {
                               FirebaseFirestore.instance
                                    .collection(Constants.firebasecollections)
                                    .doc(mytUser)
                                    .update({
                                  "saved": FieldValue.arrayRemove(
                                      [widget.data[widget.index].postId])
                                });
                              } else {
                                FirebaseFirestore.instance
                                    .collection(Constants.firebasecollections)
                                    .doc(mytUser)
                                    .update({
                                  "saved": FieldValue.arrayUnion(
                                      [widget.data[widget.index].postId])
                                });
                              }
                            },
                            child: model!.saved
                                .contains(widget.data[widget.index].postId)
                                ? Icon(CupertinoIcons.bookmark_fill)
                                : Icon(CupertinoIcons.bookmark)),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(right: w * (0.74), bottom: h * (0.01)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${widget.data[widget.index].likes.length.toString()} Likes",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: h * (0.004),
                        ),
                        Text("Discription",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Container(
                              width: w,
                              height: h * (0.08),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: w * (0.03),
                                  ),
                                  CircleAvatar(
                                    backgroundImage:
                                    NetworkImage(model!.profile!),
                                    radius: 20,
                                  ),
                                  SizedBox(
                                    width: w * (0.04),
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Add Comments"),
                                    ),
                                    width: w * (0.65),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Post",
                                        style: TextStyle(color: Colors.blue),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(width: w * (0.02)),
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(model!.profile!),
                        ),
                        SizedBox(width: w * (0.02)),
                        Text(
                          "Add a comments...",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * (0.01),
                  )
                ],
              );
            },);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
