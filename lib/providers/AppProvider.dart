import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/models/login_for_users_response.dart';
import 'package:publish_brand/repositories/Chat.dart';
import 'package:publish_brand/repositories/Message.dart';
import 'package:publish_brand/repositories/firestore_helper.dart';

class AppProvider extends ChangeNotifier {
  User myUser;
  List<User> users;
  List<Chat> allMyChats;

  getChats() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list =
        await FirestoreHelper.firestoreHelper.getChats();
    List<Chat> chats = list.map((e) {
      String chatId = e.id;
      Map<String, dynamic> map = e.data();
      map['chatId'] = chatId;
      return Chat.fromJson(map);
    }).toList();
    this.allMyChats = chats;
    notifyListeners();
  }

  sendMessage(Message message, [User otherUser]) async {
    String chatId = message.chatId;
    bool x =
        await FirestoreHelper.firestoreHelper.checkCollectionExists(chatId);
    if (otherUser == null) {
      FirestoreHelper.firestoreHelper.sendMessage(message);
    } else {
      if (!x) {
        await createChat(chatId, otherUser);
        FirestoreHelper.firestoreHelper.sendMessage(message);
      } else {
        FirestoreHelper.firestoreHelper.sendMessage(message);
      }
    }
  }

  createChat(String chatId, User otherUser) async {
    FirestoreHelper.firestoreHelper.createChat(chatId, this.myUser, otherUser);
  }

  getChatMessages(String chatId) async {}
}
