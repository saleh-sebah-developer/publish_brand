import 'package:cloud_firestore/cloud_firestore.dart';

class Message2 {
  num admin_id;
  String admin_image;
  String admin_name;
  num client_id;
  String client_image;
  String client_name;
  String content;
  Timestamp date;
  String file_mime;
  String file_name;
  String type;

  Message2(
      {this.admin_id,
      this.admin_image,
      this.admin_name,
      this.client_id,
      this.client_image,
      this.client_name,
      this.content,
      this.date,
      this.file_mime,
      this.file_name,
      this.type}); // Date


  Message2.fromMap(Map map) {
    this.admin_id = map['admin_id'];
    this.admin_image = map['admin_image'];
    this.admin_name = map['admin_name'];
    this.client_id = map['client_id'];
    this.client_image = map['client_image'];
    this.client_name = map['client_name'];
    this.content = map['content'];
   // this.date = map['date'];
    this.file_mime = map['file_mime'];
    this.file_name = map['file_name'];
    this.type = map['type'];
  }

  toMap() {
    return {
      'admin_id': admin_id,
      'admin_image': admin_image,
      'admin_name': admin_name,
      'client_id': client_id,
      'client_image': client_image,
      'client_name': client_name,
      'content': content,
      'date': date,
      'file_mime': file_mime,
      'file_name': file_name,
      'type': type
    };
  }
}
