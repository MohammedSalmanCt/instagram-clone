import 'package:cloud_firestore/cloud_firestore.dart';

CommentClass? cmodel;
class CommentClass{
  String? id;
  String? commentId;
  String? comment;
  Timestamp? commentDate;

  CommentClass(
  {
    required this.id,
    required this.commentId,
    required this.comment,
    required this.commentDate
}
);
  Map<String,dynamic> toMap() {
    final Map<String,dynamic>data=<String,dynamic> { };
    data['id']=id;
    data['commentId']= commentId;
    data['comment']=comment;
    data['commentDate']= commentDate;
     return data;
  }

  CommentClass.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    commentId= map['commentId'];
    comment= map['comment'];
    commentDate= map['commentDate'];
  }

  CommentClass copyWith({
    String? id,
    String? commentId,
    String? comment,
    Timestamp? commentDate,
  })=>CommentClass(
      id: id?? this.id,
      commentId: commentId?? this.commentId,
      commentDate: commentDate?? this.commentDate,
    comment: comment?? this.comment,

  );
}