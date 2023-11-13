import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sintask/customWidgegts/followerAppbar.dart';
import '../../Methods/Authentication.dart';
import '../../Constants/constants.dart';
import '../../main.dart';
import '../../modelClass/userModel.dart';
import '../home.dart';

class UserMain extends StatefulWidget {
  const UserMain({super.key});

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {

  Authentication _auth = Authentication();

  Stream<List<userModel>> stuser() {
    return FirebaseFirestore.instance
        .collection(Constants.firebasecollections)
        .where("id", isNotEqualTo: mytUser)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => userModel.fromMap(
                doc.data(),
              ),
            )
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: FollowAppBar(Icons: Icons.arrow_back, title1: "Users"),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: stuser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                return Expanded(
                  child: Container(  // Add the return statement here
                    height: h * 0.8,
                    child: ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(w * 0.02, h * 0.02, w * 0.02, 0),
                          child: Container(
                            height: h * 0.13,
                            child: Row(
                              children: [
                                SizedBox(width: w * 0.03),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(data![index].profile.toString()),
                                  radius: 40,
                                ),
                                SizedBox(width: w * 0.05),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(data[index].name!, style: TextStyle(fontWeight: FontWeight.w500)),
                                      SizedBox(height: h * 0.01),
                                      Text(data[index].email!),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () async {
                                    if(data[index].followers.contains(mytUser))
                                    {
                                      model= await _auth.loginuser(mytUser);

                                      data[index].reference!.update({'followers': FieldValue.arrayRemove([mytUser])});
                                    }
                                    else
                                    {
                                      data[index].reference!.update({'followers': FieldValue.arrayUnion([mytUser])});
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)
                                  ),
                                  child: Text(data[index].followers.contains(mytUser)?'Unfollow':'Follow'),
                                ),
                                SizedBox(width: w * 0.02),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Container(
                  child: Text(""),
                );
              }
            },
          )

        ],
      ),
    ));
  }
}
