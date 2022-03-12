import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:publish_brand/models/send_message_request.dart';
import '../data/dio_client.dart';
import '../models/data_response.dart';
import '../models/get_chat_message_response.dart';
import 'home_provider.dart';

class ChatProvider extends ChangeNotifier {
  List<Messages> messages;
  TextEditingController textEditingController = TextEditingController();

  clearChatMessages() {
    messages = null;
    notifyListeners();
  }
  getChatMessages(BuildContext context, String package_id) async {
    clearChatMessages();
    log('getChatMessages begin');
    getChatMessageResponse response =
        await DioClient.dioClient.getChatMessage(context, package_id);
    if (response != null) {
      log('getChatMessages success');
      if (response.status) {
        log('done');
        messages = response.messages;
        notifyListeners();
      } else {
        log(response.message.toString());
        log(response.code.toString());
      }
    } else {
      log('getChatMessages failed');
      notifyListeners();
    }
  }

  sendMessage(
      BuildContext context, SendMessageRequest sendMessageRequest) async {
    log('sendMessage begin');
    DataResponse response =
        await DioClient.dioClient.sendMessage(context, sendMessageRequest);
    if (response != null) {
      log('sendMessage success');
      if (response.status) {
        log(response.status.toString());
        textEditingController.text='';
        getChatMessages(context,
            Provider.of<HomeProvider>(context, listen: false).project_id);
        notifyListeners();
      } else {
        log(response.status.toString());
      }
    } else {
      log('sendMessage failed');
    }
    notifyListeners();
  }
}
