

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
userModel? model;


class userModel{
 String? id;
 String? name;
 String? phone;
 String? email;
 String? profile;
 Timestamp? createTime;
 Timestamp? loginTime;
 late List followers=[];
 late List following=[];
 String? password;
late List saved=[];
 DocumentReference? reference;


 userModel({
  required this.id,
  required this.name,
  required this.phone,
  required this.email,
  required this.profile,
  required this.createTime,
  required this.loginTime,
  required this.followers,
  required this.following,
  required this.password,
  required this.saved,
  this.reference

});

 //////methode
 Map<String,dynamic> toMap() {
  final Map<String,dynamic>data=<String,dynamic> { };
  data['id']=id;
   data['name']= name;
   data['phone']=phone;
   data['email']= email;
   data['profile']=profile;
   data['createTime']=createTime;
   data['loginTime']=loginTime;
   data['followers']=followers;
   data['following']=following;
   data['password']=password;
   data['reference']=reference;
   data['saved']=saved;
   return data;


 }
 userModel.fromMap(Map<String, dynamic> map) {
  id = map['id'];
  name= map['name'];
  phone = map['phone'];
  email = map['email'];
  profile = map['profile'];
  createTime =map['createTime'];
  loginTime=map['loginTime'];
  followers=map['followers'];
  following=map['following'];
  password=map['password'];
  reference=map['reference'];
  saved=map['saved'];
 }

 ////copywith
userModel copyWith(
{
 String? id,
 String? name,
 String? phone,
 String? email,
 String? profile,
 Timestamp? createTime,
 Timestamp? loginTime,
 List? followers,
 List?following,
 String? password,
 List? saved,
 DocumentReference? reference


}) => userModel(id: id ?? this.id,
    name: name?? this.name,
    phone: phone?? this.phone,
    email: email?? this.email,
    profile: profile?? this.profile,
    createTime: createTime?? this.createTime,
    loginTime: loginTime??this.loginTime,
    followers: followers?? this.followers,
   following:  following?? this.following,
   password: password?? this.password,
   saved: saved?? this.saved,
  reference: reference?? this.reference
);
}






