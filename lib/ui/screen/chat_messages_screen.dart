import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
import '../../models/get_services_details_response.dart';
import '../../models/send_message_request.dart';
import '../../providers/chatProvider.dart';
import '../../repositories/Message2.dart';
import '../../repositories/firestore_helper.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:lottie/lottie.dart';

class AllChatMessagesScreen extends StatefulWidget {
  String project_id;
  String target;
  Service service;
  int adminChatID;
  int categoryChatID;

  AllChatMessagesScreen(this.project_id, this.target, this.service,
      this.adminChatID, this.categoryChatID);

  @override
  State<AllChatMessagesScreen> createState() => _AllChatMessagesScreenState();
}

class _AllChatMessagesScreenState extends State<AllChatMessagesScreen> {
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false)
        .getChatMessages(context, widget.project_id, widget.target);
    Provider.of<AppProvider>(context, listen: false).getChatMessages(
        widget.target == 'admin'
            ? widget.adminChatID.toString()
            : widget.categoryChatID.toString());
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
                  widget.target == 'admin'
                      ? 'administration'.tr()
                      : 'competent'.tr() + widget.service.category.name,
                  style: TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                ),
                subtitle: Text(
                  widget.target == 'admin'
                      ? 'administration_department'.tr()
                      : widget.service.category.name + ' ' + 'department'.tr(),
                  style: TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                ),
                leading: GestureDetector(
                  onTap: () {
                    RouterClass.routerClass.popScreen();
                  },
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    size: 40,
                  ),
                ),
                // trailing: Text(
                //   'create_a_meeting'.tr(),
                //   style: TextStyle(fontSize: 12.sp, fontFamily: 'TajawalBold'),
                // ),
              ),
            ),
            Expanded(
              child: providerApp.listMessage2 == null
                  ? SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: Center(
                        child: Lottie.asset('assets/animations/progress1.json'),
                      ))
                  : providerApp.listMessage2.isEmpty
                      ? Center(
                          child: Lottie.asset('assets/animations/empty2.json'),
                        )
                      : Container(
                          child: ListView.builder(
                              itemCount: providerApp.listMessage2.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: providerApp
                                                .listMessage2[index]
                                                .client_id ==
                                            providerAuth.currentUser.id
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        // width: MediaQuery.of(context).size.width/2,
                                        child: ChatBubble(
                                          backGroundColor: providerApp
                                                      .listMessage2[index]
                                                      .client_id ==
                                                  providerAuth.currentUser.id
                                              ? HexColor('#E5E5EA')
                                              : HexColor('#145366'),
                                          clipper: ChatBubbleClipper5(
                                              type: providerApp
                                                          .listMessage2[index]
                                                          .client_id ==
                                                      providerAuth
                                                          .currentUser.id
                                                  ? BubbleType.sendBubble
                                                  : BubbleType.receiverBubble),
                                          child: providerApp.listMessage2[index]
                                                      .client_id ==
                                                  providerAuth.currentUser.id
                                              ? Text(
                                                  providerApp
                                                          .listMessage2[index]
                                                          .content ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  overflow:
                                                      TextOverflow.visible,
                                                )
                                              : Text(
                                                  providerApp
                                                          .listMessage2[index]
                                                          .content ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
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
                      //--------Api
                      /*
                      SendMessageRequest sendMessageRequest =
                          SendMessageRequest(
                              type: '0',
                              message: providerChat.textEditingController.text,
                              project_id: widget.project_id,
                              target: widget.target);
                      providerChat.sendMessage(
                          context, sendMessageRequest, widget.target);
                      */
                      //--------Firebase
                      Message2 message2 = Message2(
                          client_id: providerAuth.currentUser.id,
                          client_name: providerAuth.currentUser.name,
                          content: providerChat.textEditingController.text,
                          type: 'text');
                      providerApp.sendMessage(
                          message2,
                          widget.target == 'admin'
                              ? widget.adminChatID.toString()
                              : widget.categoryChatID.toString());
                      providerChat.textEditingController.text='';
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
