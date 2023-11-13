import 'package:cloud_firestore/cloud_firestore.dart';



PostClass? pmodel;
class PostClass{
  String? id;
  String? post;
  late List likes=[];
  String? postId;
  Timestamp? uploadTime;
  String? description;

  PostClass({
    required this.id,
    required this.post,
    required this.likes,
    required this.postId,
    required this.uploadTime,
    required this.description
  });

  Map<String,dynamic> toMap() {
    final Map<String,dynamic>data=<String,dynamic> { };
    data['id']= id;
    data['post']= post;
    data['likes']= likes;
    data['postId']= postId;
    data['uploadTime']=uploadTime;
    data['description']=description;
    return data;


  }
  PostClass.fromMap(Map<String, dynamic> map) {
    id= map['id'];
    post=map['post'];
    likes=map['likes'];
    postId=map['postId'];
    uploadTime =map['uploadTime'];
    description=map['description'];
  }

  PostClass copyWith({
    String? id,
    String? post,
    List? likes,
    String? postId,
    Timestamp? uploadTime,
    String? description
  })=>PostClass(
      id: id?? this.id,
      post: post?? this.post,
      likes: likes?? this.likes,
      postId: postId?? this.postId,
      uploadTime: uploadTime?? this.uploadTime,
      description: description?? this.description
  );

}