import 'dart:developer';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:image_downloader/image_downloader.dart';
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
import '../../providers/SalehProvider.dart';
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

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

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
    Provider.of<AppProvider>(context, listen: false).targetProvider =
        widget.target;
    Provider.of<AppProvider>(context, listen: false).adminChatIDProvider =
        widget.adminChatID;
    Provider.of<AppProvider>(context, listen: false).categoryChatIDProvider =
        widget.categoryChatID;
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
                trailing:
                    Column(
                      children: [
                        Icon(Icons.video_call),
                        Text(
                          'create_a_meeting'.tr(),
                          style: TextStyle(fontSize: 12.sp, fontFamily: 'TajawalBold'),
                        ),
                      ],
                    ),
                onTap: (){
                  //TODO click to create meeting
                },


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
                          child: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirestoreHelper.firestoreHelper
                              .getChatMessages(widget.target == 'admin'
                                  ? widget.adminChatID.toString()
                                  : widget.categoryChatID.toString() ?? '1'),
                          builder: (context, dataSnapShot) {
                            List<QueryDocumentSnapshot<Map<String, dynamic>>>
                                snapshots = dataSnapShot.data?.docs ?? [];
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  itemCount: snapshots.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Column(
                                        //width: MediaQuery.of(context).size.width/2,
                                        children: [
                                          ChatBubble(
                                              alignment: snapshots[index]['client_id'] ==
                                                  providerAuth.currentUser.id
                                                  ? Alignment.topRight
                                                  : Alignment.topLeft,
                                              backGroundColor: snapshots[index]
                                              ['client_id'] ==
                                                  providerAuth.currentUser.id
                                                  ? HexColor('#E5E5EA')
                                                  : HexColor('#145366'),
                                              clipper: ChatBubbleClipper5(
                                                  type: snapshots[index]['client_id'] == providerAuth.currentUser.id
                                                      ? BubbleType.sendBubble
                                                      : BubbleType
                                                      .receiverBubble),
                                              child: snapshots[index]['client_id'] ==
                                                  providerAuth.currentUser.id
                                                  ? snapshots[index]['type'] !=
                                                  'image'
                                                  ? Text(
                                                snapshots[index]
                                                ['content'] ??
                                                    ' ',
                                                style: TextStyle(
                                                    color:
                                                    Colors.black),
                                                overflow: TextOverflow
                                                    .ellipsis,
                                                maxLines: 2,
                                              )
                                                  : snapshots[index]['content'].toString().split('.').last == 'jpg' ||
                                                  snapshots[index]['content']
                                                      .toString()
                                                      .split('.')
                                                      .last ==
                                                      'jpeg ' ||
                                                  snapshots[index]['content'].toString().split('.').last == 'gif' ||
                                                  snapshots[index]['content'].toString().split('.').last == 'png' ||
                                                  snapshots[index]['content'].toString().split('.').last == 'svg'
                                                  ? GestureDetector(
                                                onLongPress: () {
                                                  showDialog(
                                                    context:
                                                    context,
                                                    builder:
                                                        (context) =>
                                                        AlertDialog(
                                                          title:
                                                          GestureDetector(
                                                              onTap:
                                                                  () async {
                                                                log('download');
                                                                try {
                                                                  // Saved with this method.
                                                                  var imageId = await ImageDownloader.downloadImage(snapshots[index]['content'], destination: AndroidDestinationType.directoryDownloads..subDirectory('publish_brand.png'));
                                                                  log('true download');
                                                                  Navigator.of(context).pop();
                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                    backgroundColor: Colors.green,
                                                                    content: Text('The image has been saved'),
                                                                    duration: Duration(seconds: 3),
                                                                  ));
                                                                  if (imageId == null) {
                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                      backgroundColor: Colors.red,
                                                                      content: Text('error download'),
                                                                      duration: Duration(seconds: 3),
                                                                    ));
                                                                    return;
                                                                  }

                                                                  // Below is a method of obtaining saved image information.
                                                                  var fileName = await ImageDownloader.findName(imageId);
                                                                  var path = await ImageDownloader.findPath(imageId);
                                                                  var size = await ImageDownloader.findByteSize(imageId);
                                                                  var mimeType = await ImageDownloader.findMimeType(imageId);
                                                                } on PlatformException catch (error) {
                                                                  print(error);
                                                                }

                                                                // await ImageDownloader.downloadImage(snapshots[index]['content'],
                                                                //   destination: AndroidDestinationType.custom( directory: '')
                                                                //     ..inExternalFilesDir()
                                                                //     ..subDirectory("custom/sample.gif"),
                                                                // );
                                                                //  Provider.of<SalehProvider>(context, listen: false).download2(snapshots[index]['content']);
                                                              },
                                                              child:
                                                              Text('Download Image')),
                                                          // content: Text('Dowmload'),
                                                        ),
                                                  );
                                                },
                                                child:
                                                Image.network(
                                                  snapshots[index]
                                                  ['content'],
                                                  width: 200,
                                                  height: 200,
                                                ),
                                              )
                                              // : snapshots[index]['content'].toString().split('.').last == 'mp3' || snapshots[index]['content'].toString().split('.').last == 'm4a'
                                              //     ? Container(
                                              //         child: GestureDetector(
                                              //             onTap: () {
                                              //               widget
                                              //                   .audioPlayer
                                              //                   .playBytes(snapshots[index]['content']);
                                              //             },
                                              //             child: Icon(Icons.play_arrow)),
                                              //       )
                                                  : GestureDetector(
                                                onTap: () {
                                                  log('download');
                                                  Provider.of<SalehProvider>(
                                                      context,
                                                      listen:
                                                      false)
                                                      .download2(snapshots[
                                                  index]
                                                  [
                                                  'content']);
                                                },
                                                child: Text(
                                                  snapshots[index][
                                                  'content']
                                                      .toString()
                                                      .split(
                                                      '/')
                                                      .last ??
                                                      'file',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightBlue),
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  maxLines: 2,
                                                ),
                                              )
                                                  : snapshots[index]['type'] != 'image'
                                                  ? Text(
                                                snapshots[index]
                                                ['content'] ??
                                                    '',
                                                style: TextStyle(
                                                    color:
                                                    Colors.white),
                                                overflow: TextOverflow
                                                    .ellipsis,
                                                maxLines: 2,
                                              )
                                                  : snapshots[index]['content'].toString().split('.').last == 'jpg' || snapshots[index]['content'].toString().split('.').last == 'jpeg ' || snapshots[index]['content'].toString().split('.').last == 'gif' || snapshots[index]['content'].toString().split('.').last == 'png' || snapshots[index]['content'].toString().split('.').last == 'svg'
                                                  ? GestureDetector(
                                                onLongPress: () {
                                                  showDialog(
                                                    context:
                                                    context,
                                                    builder:
                                                        (context) =>
                                                        AlertDialog(
                                                          title:
                                                          GestureDetector(
                                                              onTap:
                                                                  () async {
                                                                log('download');
                                                                try {
                                                                  // Saved with this method.
                                                                  var imageId = await ImageDownloader.downloadImage(snapshots[index]['content'], destination: AndroidDestinationType.directoryDownloads..subDirectory('publish_brand.png'));
                                                                  log('true download');
                                                                  Navigator.of(context).pop();
                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                    backgroundColor: Colors.green,
                                                                    content: Text('The image has been saved'),
                                                                    duration: Duration(seconds: 3),
                                                                  ));
                                                                  if (imageId == null) {
                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                      backgroundColor: Colors.red,
                                                                      content: Text('error download'),
                                                                      duration: Duration(seconds: 3),
                                                                    ));
                                                                    return;
                                                                  }

                                                                  // Below is a method of obtaining saved image information.
                                                                  var fileName = await ImageDownloader.findName(imageId);
                                                                  var path = await ImageDownloader.findPath(imageId);
                                                                  var size = await ImageDownloader.findByteSize(imageId);
                                                                  var mimeType = await ImageDownloader.findMimeType(imageId);
                                                                } on PlatformException catch (error) {
                                                                  print(error);
                                                                }

                                                                // await ImageDownloader.downloadImage(snapshots[index]['content'],
                                                                //   destination: AndroidDestinationType.custom( directory: '')
                                                                //     ..inExternalFilesDir()
                                                                //     ..subDirectory("custom/sample.gif"),
                                                                // );
                                                                //  Provider.of<SalehProvider>(context, listen: false).download2(snapshots[index]['content']);
                                                              },
                                                              child:
                                                              Text('Download Image')),
                                                          // content: Text('Dowmload'),
                                                        ),
                                                  );
                                                },
                                                child:
                                                Image.network(
                                                  snapshots[index]
                                                  ['content'],
                                                  width: 200,
                                                  height: 200,
                                                ),
                                              )
                                              // : snapshots[index]['content'].toString().split('.').last == 'mp3' || snapshots[index]['content'].toString().split('.').last == 'm4a'
                                              //     ? Container(
                                              //         child: GestureDetector(
                                              //             onTap: () async {
                                              //               widget
                                              //                   .audioPlayer
                                              //                   .play(snapshots[index]['content']);
                                              //               int result = await widget
                                              //                   .audioPlayer
                                              //                   .play(snapshots[index]['content']);
                                              //               if (result ==
                                              //                   1) {
                                              //                 log('1');
                                              //                 // success
                                              //               }
                                              //             },
                                              //             child: Icon(Icons.play_arrow)),
                                              //       )
                                                  : GestureDetector(
                                                onTap: () {
                                                  log('download');
                                                  Provider.of<SalehProvider>(
                                                      context,
                                                      listen:
                                                      false)
                                                      .download2(snapshots[
                                                  index]
                                                  [
                                                  'content']);
                                                },
                                                child: Text(
                                                  snapshots[index][
                                                  'content']
                                                      .toString()
                                                      .split(
                                                      '/')
                                                      .last ??
                                                      'file',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightBlue),
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  maxLines: 2,
                                                ),
                                              )),
                                          SizedBox(height: 2,),
                                          Container(
                                            alignment:
                                            snapshots[index]['client_id'] ==
                                              providerAuth.currentUser.id
                                              ? Alignment.topRight
                                                  : Alignment.topLeft
                                            ,
                                            child: Text(
                                                DateTime.fromMillisecondsSinceEpoch(int.parse(snapshots[index]['date']) ).toString().substring(0,16)??'',
                                              // DateTime.parse(snapshots[index]
                                              // ['date'].toDate().toString()).toString().substring(0,16)
                                              //     ??
                                              //     ' ',
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color:
                                                  Colors.black),
                                              overflow: TextOverflow
                                                  .ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            );
                          },
                        )),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: providerChat.textEditingController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () => providerApp.getImage(
                                  context,
                                  widget.target == 'admin'
                                      ? widget.adminChatID.toString()
                                      : widget.categoryChatID.toString()),
                              icon: Icon(Icons.attach_file)),
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
                      // DateTime.now().millisecondsSinceEpoch
                      // Timestamp.now()
                      Message2 message2 = Message2(
                          client_id: providerAuth.currentUser.id,
                          client_name: providerAuth.currentUser.name,
                          content: providerChat.textEditingController.text,
                          date:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          type: 'text');
                      providerApp.sendMessage(
                          message2,
                          widget.target == 'admin'
                              ? widget.adminChatID.toString()
                              : widget.categoryChatID.toString());
                      //TODO send audio and video on chat and download it
                      providerApp.sendMessageNotification(
                          context,
                          widget.target == 'admin'
                              ? widget.adminChatID
                              : widget.categoryChatID,
                          message2);
                      providerChat.textEditingController.text = '';
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
