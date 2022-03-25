import 'dart:developer';
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/models/login_for_users_response.dart';
import 'package:publish_brand/repositories/Chat.dart';
import 'package:publish_brand/repositories/Message.dart';
import 'package:publish_brand/repositories/firestore_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';


class AppProvider extends ChangeNotifier {
  User myUser;
  List<User> users;
  List<Message> allMyChats;
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;

  getChatsWithAdmin(User user) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list =
        await FirestoreHelper.firestoreHelper.getAdminChat(user);

    List<Message> messages = list.map((e) {
      String chatId = e.id;
      Map<String, dynamic> map = e.data();
      log(map.toString());
      map['chatId'] = chatId;
      return Message.fromMap(map);
    }).toList();
    log(messages.length.toString());
    this.allMyChats = messages;
    notifyListeners();
  }

  sendMessage(Message message,User user) async {
    FirestoreHelper.firestoreHelper.sendMessage(message,user);
    /*
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
    */
  }

  createChat(String chatId, User otherUser) async {
    FirestoreHelper.firestoreHelper.createChat(chatId, this.myUser, otherUser);
  }

  getChatMessages(String chatId) async {}

  checkInternetConnection({bool hasInternet, ConnectivityResult result}) async {
/*
    this.hasInternet = hasInternet;
    this.result = result;
    notifyListeners();
    this.hasInternet = await InternetConnectionChecker().hasConnection;
    this.result = await (Connectivity().checkConnectivity());
    final color = this.hasInternet ? Colors.green : Colors.red;
    final text = this.hasInternet ? 'Internet' : 'No Internet';
    if (this.result != ConnectivityResult.wifi) {
      showSimpleNotification(
        Text(
          "$text: No Network",
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),
        background: color,
        duration: Duration(seconds: 5),
        slideDismissDirection: DismissDirection.horizontal,
      );
    } else {
      // showSimpleNotification(
      //   Text(
      //     "$text: Wifi Network",
      //     style: TextStyle(color: Colors.white, fontSize: 20.sp),
      //   ),
      //   background: color,
      //   duration: Duration(microseconds: 1),
      //   slideDismissDirection: DismissDirection.horizontal,
      //
      // );
    }
    notifyListeners();
*/
  }

    // void showDownloadProgress(received, total) {
    //   if (total != -1) {
    //     print((received / total * 100).toStringAsFixed(0) + "%");
    //   }
    //
    // }
    Future download2(String url) async {
      try {

        if (await Permission.storage.request().isGranted) {
          String path =
          await AndroidPathProvider.downloadsPath;
          //String fullPath = tempDir.path + "/boo2.pdf'";
          String fullPath = "$path/test.docx";
          print('full path ${fullPath}');
          Response response = await Dio().get(
            url,
           // onReceiveProgress: showDownloadProgress,
            //Received data with List<int>
            options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                validateStatus: (status) {
                  return status < 500;
                }),
          );
          log(response.headers.toString());
          log(fullPath.toString());
          File file = File(fullPath);
          var raf = file.openSync(mode: FileMode.write);
          // response.data is List<int> type
          raf.writeFromSync(response.data);
          await raf.close();
          OpenFile.open(fullPath);}
      } catch (e) {
        print(e);
      }
    }

}
