import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sintask/Old/home.dart';
import '../mainPages/signingAndLogin/Login.dart';
import '../Constants/constants.dart';
import '../modelClass/userModel.dart';



class Followerr extends StatefulWidget {
  const Followerr({super.key});

  @override
  State<Followerr> createState() => _FollowerrState();
}
class _FollowerrState extends State<Followerr> {



  Stream<List<userModel>> stuser() {
    return FirebaseFirestore.instance
        .collection(Constants.firebasecollections)
    .where('id',whereIn: model!.followers)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map(
          (doc) => userModel.fromMap(
        doc.data(),
      ),
    )
        .toList());
  }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   stuser();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                      (route) => false);
            },
            child: Icon(Icons.arrow_back)),
        title: Center(child: Text("Followers")),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: search,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                suffixIcon: GestureDetector(
                  child: Icon(Icons.close),
                  onTap: () {
                    clearText();
                    setState(() {
                      Container();
                    });
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white10)),
              ),
            ),
            SizedBox(
              height: h * (0.05),
            ),
            StreamBuilder<List<userModel>>(
              stream: stuser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          if(search.text.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Container(
                                  height: h * (0.3),
                                  width: w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: w * (0.02)),
                                      Text('${index + 1}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: h * (0.03))),
                                      SizedBox(
                                        width: w * (0.03),
                                      ),
                                      Container(
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              data[index].profile.toString()),
                                          radius: h * (0.06),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * (0.05),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(data[index].name.toString()),
                                            SizedBox(
                                              height: h * (0.03),
                                            ),
                                            Text(data[index].email.toString())
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            // }
                            // else if (data[index]
                            //     .name!
                            //     .toLowerCase()
                            //     .toString()
                            //     .contains(search.text.toLowerCase())) {
                            //   return Padding(
                            //     padding: const EdgeInsets.only(bottom: 30),
                            //     child: Container(
                            //       height: height * (0.3),
                            //       width: width,
                            //       decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         borderRadius: BorderRadius.circular(20),
                            //       ),
                            //       child: Row(
                            //         children: [
                            //           SizedBox(width: width * (0.02)),
                            //           Text('${index + 1}',
                            //               style: TextStyle(
                            //                   fontWeight: FontWeight.w800,
                            //                   fontSize: height * (0.03))),
                            //           SizedBox(
                            //             width: width * (0.03),
                            //           ),
                            //           Container(
                            //             child: CircleAvatar(
                            //               backgroundImage: NetworkImage(
                            //                   data[index].profile.toString()),
                            //               radius: height * (0.06),
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             width: width * (0.05),
                            //           ),
                            //           Expanded(
                            //             child: Column(
                            //               mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //               children: [
                            //                 Text(data[index].name.toString()),
                            //                 SizedBox(
                            //                   height: height * (0.03),
                            //                 ),
                            //                 Text(data[index].email.toString())
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   );
                            // } else {
                            //   return Container();
                            // }
                          // }
                        }
                        }
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
      ),
    );
  }
}
