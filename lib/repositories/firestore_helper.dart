import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:publish_brand/models/login_for_users_response.dart';
import 'package:publish_brand/repositories/Message.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String usersCollectionName = 'Users';
  final String chatsCollectionName = 'Chats';
  final String messagesCollectionName = 'Messages';

  registerUser(User user) async {
    firebaseFirestore
        .collection(usersCollectionName)
        .doc(user.id.toString()) // id just number?
        .set(user.toJson());
  }

  sendMessage(Message message) async {
    firebaseFirestore
        .collection(chatsCollectionName)
        .doc(message.chatId)
        .set(message.toMap());
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


  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getChats() async {
    //String myId = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection(chatsCollectionName)
        // .where('membersIds', arrayContains: myId)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    return docs;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(String chatId) {
    return firebaseFirestore
        .collection(chatsCollectionName)
        .doc(chatId)
        .collection(messagesCollectionName)
        .orderBy('sentTime')
        .snapshots();
  }
}
