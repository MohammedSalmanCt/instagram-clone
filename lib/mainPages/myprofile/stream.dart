import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../../Constants/Constants.dart';
import '../../main.dart';
import '../../modelClass/userModel.dart';
import '../../modelClass/postModel.dart';
import '../home.dart';

class Streamb extends StatefulWidget {
  const Streamb({super.key});

  @override
  State<Streamb> createState() => _StreambState();
}

class _StreambState extends State<Streamb> {
  Stream<List<PostClass>> strPost() {
    return FirebaseFirestore.instance
        .collection(Constants.firebasecollections)
        .doc(mytUser).collection("posts")
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map(
          (doc) => PostClass.fromMap(
        doc.data(),
      ),
    )
        .toList());
  }
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: strPost(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var data=snapshot.data;
          return Container(
            height: h * 0.6,
            width: w,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 0.9),
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Container(
                  // color: Colors.green,
                  child: Image.network("data[index].post.toString()",
                  fit:BoxFit.cover),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}

