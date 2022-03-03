import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String messageId;
  String chatId;
  String content;
  String senderId;
  FieldValue sentTime;
  String image;
  // Date

  Message({this.content, this.senderId, this.chatId, this.image});

  toMap() {
    return {
      'content': content,
      'senderId': senderId,
      'sentTime': sentTime,
      'image': image
    };
  }
}
