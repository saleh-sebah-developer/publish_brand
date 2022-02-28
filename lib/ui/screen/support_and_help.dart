import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/ui/screen/price_details.dart';
import 'package:publish_brand/ui/screen/service_details.dart';
import 'about_loyalty_points.dart';
import 'contact_technical_support.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'how_to_request_services.dart';

class SupportAndHelpScreen extends StatelessWidget {
  const SupportAndHelpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'support_and_help'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 6.h,),
          GestureDetector(
            onTap: (){
              RouterClass.routerClass.pushToScreenUsingWidget(const AboutLoyaltyPointsScreen());
            },
            child: Card(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h),
                child: ListTile(
                  title: Text(
                    'about_loyalty_points'.tr(),
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h,),
          GestureDetector(
            onTap: (){
              RouterClass.routerClass.pushToScreenUsingWidget(const HowToRequestServicesScreen());
            },
            child: Card(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h),
                child: ListTile(
                  title: Text(
                    'how_to_request_services'.tr(),
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h,),
          GestureDetector(
            onTap: (){
              RouterClass.routerClass.pushToScreenUsingWidget(const PriceDetailsScreen());
            },
            child: Card(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h),
                child: ListTile(
                  title: Text(
                    'price_details'.tr(),
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h,),
          GestureDetector(
            onTap: (){
              RouterClass.routerClass.pushToScreenUsingWidget(const ServiceDetailsTextScreen());
            },
            child: Card(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h),
                child: ListTile(
                  title: Text(
                    'service_details'.tr(),
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h,),
          GestureDetector(
            onTap: (){
              RouterClass.routerClass.pushToScreenUsingWidget(ContactTechnicalSupportScreen());
            },
            child: Card(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h),
                child: ListTile(
                  title: Text(
                    'contact_technical_support'.tr(),
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
