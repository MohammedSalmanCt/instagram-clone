import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintask/customWidgegts/followerAppbar.dart';
import 'package:sintask/main.dart';
import '../../Constants/Constants.dart';
import '../../Methods/Authentication.dart';
import '../../modelClass/userModel.dart';
import '../../modelClass/postModel.dart';
import '../home.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final Authentication _auth=Authentication();
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Spacer(),
              GestureDetector(
                 onTap: () async {
                   ImagePicker imagePicker=ImagePicker();
                   XFile? file= await imagePicker.pickImage(source: ImageSource.camera,imageQuality: 30);
                   if(file==null)return;
                   String uniqueFileName=DateTime.now().microsecondsSinceEpoch.toString();
                   Reference referenceRoot=FirebaseStorage.instance.ref();
                   Reference referenceDirImage=referenceRoot.child('myposts');
                   Reference referenceImageToUpload=referenceDirImage.child(uniqueFileName);
                   try{
                     await referenceImageToUpload.putFile(File(file.path));
                     imageUrl= await referenceImageToUpload.getDownloadURL();
                     model=await _auth.loginuser(mytUser);
                     PostClass postObj=PostClass(id: mytUser,
                         post: imageUrl,
                         likes:[],
                         postId:'' ,
                         description: "",
                         uploadTime: Timestamp.now());
                     var firebasePostConst=FirebaseFirestore.instance.collection(Constants.firebasecollections)
                         .doc(mytUser).collection('posts');
                    firebasePostConst .add(postObj.toMap()).then((value) async {
                      print(value);
                      print("----------------");
                           pmodel=await _auth.getPost(value.id);
                           var a=pmodel?.copyWith(postId: value.id,description: '');
                           value.update(a!.toMap());
                     });

                   }
                   catch(error)
                   {
                     print("uploading is error");
                   }
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AddPost()), (route) => false);
                 },
                child: Icon(Icons.add_a_photo_outlined,
                size: h*(0.15)),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  ImagePicker imagePicker=ImagePicker();
                  XFile? file= await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 30);
                  if(file==null)return;
                  String uniqueFileName=DateTime.now().microsecondsSinceEpoch.toString();
                  Reference referenceRoot=FirebaseStorage.instance.ref();
                  Reference referenceDirImage=referenceRoot.child('myposts');
                  Reference referenceImageToUpload=referenceDirImage.child(uniqueFileName);
                  try{
                    await referenceImageToUpload.putFile(File(file.path));
                    imageUrl= await referenceImageToUpload.getDownloadURL();
                    model=await _auth.loginuser(mytUser);
                    PostClass postObj=PostClass(id: mytUser,
                        post: imageUrl,
                        likes:[],
                        postId:'' ,
                        description: "",
                        uploadTime: Timestamp.now());
                    var firebasePostConst=FirebaseFirestore.instance.collection(Constants.firebasecollections)
                        .doc(mytUser).collection('posts');
                    firebasePostConst .add(postObj.toMap()).then((value) async {
                      pmodel=await _auth.getPost(value.id);
                      print(value);
                      print("value");
                      var a=pmodel!.copyWith(postId: value.id,description: "");
                      print("object");
                      firebasePostConst.doc(value.id).update(a.toMap());
                      print("cccccc");

                    });

                  }
                  catch(error)
                  {
                    print("uploading is error");
                  }
                },
                child: Icon(Icons.add_photo_alternate_outlined,
                size: h*(0.15)),
              ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
