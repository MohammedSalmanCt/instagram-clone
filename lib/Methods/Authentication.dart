
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sintask/Constants/constants.dart';
import 'package:sintask/mainPages/home.dart';
import 'package:sintask/modelClass/userModel.dart';
import '../main.dart';
import '../modelClass/commentModel.dart';
import '../modelClass/postModel.dart';

String imageUrl='';

class Authentication {
  ///google signup
  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      final userData = userModel(id: value.user!.uid,
          name: googleUser!.displayName!,
          phone: " ",
          email: googleUser.email,
          profile: googleUser.photoUrl!,
          createTime: Timestamp.now(),
          loginTime: Timestamp.now(),
          followers: [],
          following: [],
          saved: [],
          password: "");
      usernow = value.user!.uid;


      if (value.additionalUserInfo?.isNewUser ?? true) {
        FirebaseFirestore.instance.collection(Constants.firebasecollections).
        doc(value.user!.uid).set(
            userData.toMap());
      }

      else {
        loginuser(usernow);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('uid', mytUser);

        var store = model?.copyWith(loginTime: Timestamp.now());
        FirebaseFirestore.instance.collection('user')
            .doc(value.user!.uid)
            .update(store!.toMap());
      }
    });
  }


  getuser(BuildContext context, email, passwrd, name, Ph, Conpass) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.toString(), password: passwrd.toString()).then((value) {
      final _userNow = value.user;
      if (_userNow != null) {
        final signData = userModel(id: _userNow.uid,
            name: name.toString(),
            phone: Ph.toString(),
            email: email.toString(),
            profile: "",
            createTime: Timestamp.now(),
            loginTime: Timestamp.now(),
            followers: [],
            following: [],
            saved: [],
            password: passwrd.toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage(),));
        FirebaseFirestore.instance.collection(Constants.firebasecollections)
            .doc(
            _userNow.uid)
            .set(signData.toMap());
      }
    }
    );
  }

  getusrr(email, passwrd, context) {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text, password: passwrd.text)
        .then((value) {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }


  loginuser(String usernow) async {
    DocumentSnapshot<Map<String, dynamic>>snapshot = await
    FirebaseFirestore.instance.collection(Constants.firebasecollections).doc(
        usernow).get();

    if (snapshot.exists) {
      model = userModel.fromMap(snapshot.data()!);
      return model;
    }
  }

////////curentUserid in model var
  getur()
  async {
    model=await loginuser(FirebaseAuth.instance.currentUser!.uid);
  }


//////post data get

  getPost(String pid) async {
    DocumentSnapshot<Map<String, dynamic>>snapshot = await
    FirebaseFirestore.instance.collection(Constants.firebasecollections).doc(
        mytUser).collection('posts').doc(pid).get();
    if (snapshot.exists) {
      var pdata = PostClass.fromMap(snapshot.data()!);
      return pdata;
    }
  }

  /////comment data get
  getComment(String a,String b,String c)
  async {
    DocumentSnapshot<Map<String, dynamic>>snapshot = await
    FirebaseFirestore.instance.collection(Constants.firebasecollections).doc(a)
        .collection('posts').doc(b).collection("comments").doc(c).get();
    if (snapshot.exists) {
      var cdata = CommentClass.fromMap(snapshot.data()!);
      return cdata;
    }
  }

///// edit image in camera

  camera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    if (file == null) return;
    String uniqueFileName = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('media');

    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      model = await loginuser(mytUser);
      var a = await model!.copyWith(profile: imageUrl);
      FirebaseFirestore.instance.collection(Constants.firebasecollections).doc(
          mytUser).update(a.toMap());
    } catch (error) {
      print("sssssssssssssssssssssssssssssssssssssssssssssssssssss");
    }
  }

//// edit image in camera
  media() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file == null) return;
    String uniqueFileName = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('media');

    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      model = await loginuser(mytUser);
      var a = model!.copyWith(profile: imageUrl);
      FirebaseFirestore.instance.collection(Constants.firebasecollections).doc(
          mytUser).update(a.toMap());
    } catch (error) {
      print("sssssssssssssssssssssssssssssssssssssssssssssssssssss");
    }
  }

 
}