import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sintask/mainPages/signingAndLogin/Login.dart';
import 'package:sintask/Constants/constants.dart';
import 'package:sintask/Old/followers.dart';
import 'package:sintask/Old/following.dart';
import 'package:sintask/modelClass/userModel.dart';
import 'package:sintask/Old/post.dart';
import '../Methods/Authentication.dart';
import '../mainPages/myprofile/EditProfile/Editpro.dart';
import '../main.dart';



void clearText() {
  search.clear();
}
TextEditingController search=TextEditingController();
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Authentication _auth = Authentication();

  mypro() {
    FirebaseFirestore.instance
        .collection(Constants.firebasecollections)
        .doc(mytUser)
        .get()
        .then(
      (value) {
         model = userModel.fromMap(value.data()!);
        if (mounted) {
          setState(() {});
        }
      },
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mypro();
  }



  TextEditingController search = TextEditingController();
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
        endDrawer: EndDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 6,
          leading: InkWell(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
                (route) => false),
            child: Icon(
              Icons.arrow_back,
              size: h * (0.03),
            ),
          ),
          title: Center(
            child: Text("Users List",
                style: TextStyle(
                  fontSize: h * (0.03),
                  fontWeight: FontWeight.w800,
                )),
          ),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: Icon(Icons.menu));
            }),
          ],
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
              StreamBuilder(
                stream: stuser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (context, index) {
                            if (search.text.isEmpty) {
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
                                      SizedBox(
                                        width: w * (0.02),
                                      ),
                                      Container(
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              print(data[index]);
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
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w800)),
                                            child: Text(data[index].followers.contains(mytUser)?'Unfollow':'Follow')
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * (0.01),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else if (data[index]
                                   .name!
                                .toLowerCase()
                                .toString()
                                .contains(search.text.toLowerCase())) {
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
                                      SizedBox(
                                        width: w * (0.02),
                                      ),
                                      Container(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary:Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800)),
                                          onPressed: () {
                                            if(data[index].followers.contains(mytUser))
                                            {
                                              data[index].reference!.update(
                                                  {'followers':FieldValue.arrayRemove([mytUser])});
                                            }
                                            else
                                            {
                                             data[index].reference!.update({'followers': FieldValue.arrayUnion([mytUser])});
                                            }
                                          },
                                          child:
                                              Text(data[index].followers!.contains(mytUser) ?"Unfollow":'Follow')
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * (0.01),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
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
      ),
    );
  }
}

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: h * (0.2),
            width: w,
            color: Colors.green,
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  backgroundImage: NetworkImage(model!.profile!),
                ),
                title: Text(model!.name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Checkbox.width,
                    )),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => EditPro(),));
                  },
                  child: Container(
                    color: Colors.grey.shade200,
                    height: h *(0.04),
                    width: w *(0.1),
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),

                  ),
                ),
              ),
            ),

          ),
          Expanded(
            child: Container(
              height: h * (0.8),
              width: w,
              color: Colors.white,
              child: Column(
                children: [
                  GestureDetector(
                    child: ListTile(
                      leading: Icon(
                        Icons.person_add_alt_1,
                        color: Colors.red,
                      ),
                      title: Text("Followers"),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>Followerr(),));
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Following(),));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.person_add_alt_1,
                        color: Colors.red,
                      ),
                      title: Text("followings"),
                    ),
                  ),
                  GestureDetector(
                    child: ListTile(
                      leading: Icon(
                        Icons.perm_media,
                      ),
                      title: Text("Post"),
                    ),
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Post(),));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 360),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          height: h * (0.07), width: w / 2),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              textStyle: TextStyle(
                                  fontSize: w / 23,
                                  fontWeight: FontWeight.w800)),
                          child: Text("Log Out"),
                          onPressed: () async {
                            SharedPreferences pref=await SharedPreferences.getInstance();
                            pref.remove('uid');
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false);
                          }),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

