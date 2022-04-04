import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/models/get_services_details_response.dart';
import 'package:publish_brand/models/home_response.dart';
import 'package:publish_brand/providers/AppProvider.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/chat_messages_screen.dart';
import 'package:publish_brand/ui/screen/service_details_screen.dart';
import 'package:publish_brand/ui/screen/service_details_screen2.dart';
import 'package:publish_brand/ui/widget/custom_service2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProjectDetailsScreen extends StatelessWidget {
  Service _service;
  String project_id;
  int adminChatID;
  int categoryChatID;

  ProjectDetailsScreen(
      this._service, this.project_id, this.adminChatID, this.categoryChatID);

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false)
        .getMyProjectDetails(context, project_id);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'project_details'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _service != null
                ? GestureDetector(
                    onTap: () {
                      RouterClass.routerClass.pushToScreenUsingWidget(
                          ServiceDetailsScreen2(_service.id));
                    },
                    child: CustomService2(
                      title: _service.title ?? 'null',
                      price: _service.price.toString() ?? '0',
                      status: _service.status ?? 'new',
                      imageService: _service.photos[0].file ?? 'null',
                      type: _service.type ?? ' ',
                      pointsCount: _service.pointsCount ?? ' ',
                    ),
                  )
                : Container(),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              child: Text(
                'conversations'.tr(),
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'TajawalBold',
                    color: Colors.black),
                textAlign: TextAlign.end,
              ),
            ),
            Visibility(
              visible: true,
              child: GestureDetector(
                onTap: () {
                  // Provider.of<AppProvider>(context, listen: false)
                  //     .getChatsWithAdmin(
                  //         Provider.of<ApiAuthProvider>(context, listen: false)
                  //             .currentUser);
                  RouterClass.routerClass.pushToScreenUsingWidget(
                      AllChatMessagesScreen(project_id, 'admin', _service,
                          adminChatID, categoryChatID));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 4.w, left: 4.w, top: 12.h),
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ListTile(
                    title: Text('administration'.tr(),
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'TajawalBold',
                            color: Colors.black)),
                    subtitle: Text('administration_department'.tr(),
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'TajawalRegular',
                            color: Colors.black)),
                    trailing: Visibility(
                      visible: false,
                      child: Text('5:20am',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'TajawalRegular',
                              color: Colors.black)),
                    ),
                    leading: Image(
                      height: 35.h,
                      width: 35.w,
                      image: const AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
              ),
            ),
            _service != null
                ? Visibility(
                    visible: true,
                    child: GestureDetector(
                      onTap: () {
                        RouterClass.routerClass.pushToScreenUsingWidget(
                            AllChatMessagesScreen(project_id, 'category',
                                _service, adminChatID, categoryChatID));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(right: 4.w, left: 4.w, top: 12.h),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: ListTile(
                          title: Text('competent'.tr() + _service.category.name,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'TajawalBold',
                                  color: Colors.black)),
                          subtitle: Text(
                              _service.category.name + ' ' + 'department'.tr(),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'TajawalRegular',
                                  color: Colors.black)),
                          // trailing: Text('5:20am',
                          //     style: TextStyle(
                          //         fontSize: 14.sp,
                          //         fontFamily: 'TajawalRegular',
                          //         color: Colors.black)),
                          leading: Image(
                            height: 35.h,
                            width: 35.w,
                            image: const AssetImage('assets/images/logo.png'),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
