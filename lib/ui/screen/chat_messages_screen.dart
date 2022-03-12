import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:provider/provider.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/AppProvider.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:publish_brand/repositories/Message.dart';
import '../../models/send_message_request.dart';
import '../../providers/chatProvider.dart';
import '../../repositories/firestore_helper.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class AllChatMessagesScreen extends StatefulWidget {
  String project_id;

  AllChatMessagesScreen(this.project_id);

  @override
  State<AllChatMessagesScreen> createState() => _AllChatMessagesScreenState();
}

class _AllChatMessagesScreenState extends State<AllChatMessagesScreen> {

  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false)
        .getChatMessages(context, widget.project_id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<ApiAuthProvider, HomeProvider, AppProvider, ChatProvider>(
        builder: (context, providerAuth, providerHome, providerApp,
            providerChat, x) {
      return Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: ListTile(
                title: Text(
                  'administration'.tr(),
                  style: TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                ),
                subtitle: Text(
                  'administration_department'.tr(),
                  style: TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                ),
                leading: GestureDetector(
                  onTap: () {
                    RouterClass.routerClass.popScreen();
                  },
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 40,
                  ),
                ),
                trailing: Text(
                  'create_a_meeting'.tr(),
                  style: TextStyle(fontSize: 12.sp, fontFamily: 'TajawalBold'),
                ),
              ),
            ),
            Visibility(
              visible: false,
              child: RaisedButton(
                onPressed: () {
                  // Provider.of<AppProvider>(context, listen: false)
                  //     .getChatsWithAdmin(
                  //         Provider.of<ApiAuthProvider>(context, listen: false)
                  //             .currentUser);
                },
              ),
            ),
            Expanded(
              child: providerChat.messages == null
                  ? Container()
                  : Container(
                      child: ListView.builder(
                          itemCount: providerChat.messages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: providerChat
                                            .messages[index].senderId ==
                                        providerAuth.currentUser.id.toString()
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  ChatBubble(
                                    backGroundColor:
                                        providerChat.messages[index].senderId ==
                                                providerAuth.currentUser.id
                                                    .toString()
                                            ? HexColor('#E5E5EA')
                                            : HexColor('#145366'),
                                    clipper: ChatBubbleClipper5(
                                        type: providerChat
                                                    .messages[index].senderId ==
                                                providerAuth.currentUser.id
                                                    .toString()
                                            ? BubbleType.sendBubble
                                            : BubbleType.receiverBubble),
                                    child: providerChat
                                                .messages[index].senderId ==
                                            providerAuth.currentUser.id
                                                .toString()
                                        ? Text(
                                            providerChat
                                                .messages[index].message,
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        : Text(
                                            providerChat
                                                .messages[index].message,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: providerChat.textEditingController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      SendMessageRequest sendMessageRequest =
                          SendMessageRequest(
                        type: '0',
                        message: providerChat.textEditingController.text,
                        project_id: widget.project_id,
                      );
                      providerChat.sendMessage(context, sendMessageRequest);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: HexColor('#4091AF'),
                        shape: BoxShape.circle,
                      ),
                      child: Image(
                        height: 24.h,
                        width: 24.w,
                        color: Colors.white,
                        image: const AssetImage('assets/icons/ic_send.png'),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
