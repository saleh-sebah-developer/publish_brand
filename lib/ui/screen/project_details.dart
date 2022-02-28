import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/models/get_services_details_response.dart';
import 'package:publish_brand/models/home_response.dart';
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
  ProjectDetailsScreen(this._service,this.project_id);

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context,listen: false).getMyProjectDetails(context,project_id);

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
            GestureDetector(
              onTap: (){
                RouterClass.routerClass.pushToScreenUsingWidget( ServiceDetailsScreen2(_service.id));
              },
              child: CustomService2(
                title:
                _service.title??'null',
                price: _service.price.toString()??'0',
                status: _service.status??'new',
                imageService: _service.photos[0].file??'null',
              ),
            ),
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
            GestureDetector(
              onTap: (){
                RouterClass.routerClass.pushToScreenUsingWidget(AllChatMessagesScreen());
              },
              child: Container(
                margin: EdgeInsets.only(right: 4.w, left: 4.w, top: 12.h),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ListTile(
                  title: Text('مختص التصميم',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'TajawalBold',
                          color: Colors.black)),
                  subtitle: Text(
                      'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'TajawalRegular',
                          color: Colors.black)),
                  trailing: Text('5:20am',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'TajawalRegular',
                          color: Colors.black)),
                  leading: Image(
                    height: 35.h,
                    width: 35.w,
                    image: const AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                RouterClass.routerClass.pushToScreenUsingWidget(AllChatMessagesScreen());
              },
              child: Container(
                margin: EdgeInsets.only(right: 4.w, left: 4.w, top: 12.h),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ListTile(
                  title: Text('الادارة',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'TajawalBold',
                          color: Colors.black)),
                  subtitle: Text(
                      'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'TajawalRegular',
                          color: Colors.black)),
                  trailing: Text('5:20am',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'TajawalRegular',
                          color: Colors.black)),
                  leading: Image(
                    height: 35.h,
                    width: 35.w,
                    image: const AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}