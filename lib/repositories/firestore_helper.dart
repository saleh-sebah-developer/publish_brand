import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:publish_brand/models/login_for_users_response.dart';
import 'package:publish_brand/repositories/Message.dart';

import 'Message2.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String usersCollectionName = 'Users';
  final String chatsCollectionName = 'chats';
  final String messagesCollectionName = 'messages';

  registerUser(User user) async {
    firebaseFirestore
        .collection(usersCollectionName)
        .doc(user.id.toString())
        .set(user.toJson());
  }

  createChatWithAdmin(User user) async {
    firebaseFirestore.collection('chats').doc(user.id.toString()).set({
      'users': [user.id.toString()],
      'isChatWithAdmin': true
    });
    // firebaseFirestore.collection('chats').doc(user.id.toString()).collection('messages').add({});
  }

  sendMessage(Message2 message2, String projectID) async {
   // message2.date = FieldValue.serverTimestamp();
    await firebaseFirestore
        .collection(chatsCollectionName)
        .doc(projectID)
        .collection(messagesCollectionName)
        .add(message2.toMap());
  }

  Future<bool> checkCollectionExists(String chatiD) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await firebaseFirestore
        .collection(chatsCollectionName)
        .doc(chatiD)
        .get();
    if (doc.exists) {
      return true;
    } else {
      return false;
    }
  }

  createChat(String chatId, User myUser, User otherUser) async {
    await firebaseFirestore.collection(chatsCollectionName).doc(chatId).set({
      'membersIds': [myUser.id, otherUser.id],
      'membersNames': [myUser.name, otherUser.name]
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAdminChat(
      String projectID) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection(chatsCollectionName)
        .doc(projectID.toString())
        .collection(messagesCollectionName)
        .orderBy('date',descending: false)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> adminMessages =
        querySnapshot.docs;
    return adminMessages;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(String chatId) {

    return firebaseFirestore
        .collection(chatsCollectionName)
        .doc(chatId)
        .collection(messagesCollectionName)
        .orderBy('date',descending: false)
        .snapshots();
  }
}
