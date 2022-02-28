import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/ui/screen/privacy_policies.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:publish_brand/ui/screen/service_policies.dart';
import 'package:publish_brand/ui/screen/terms_and_conditions.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        // Try removing opacity to observe the lack of a blur effect and of sliding content.
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'السياسات',
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 6.h,
          ),
          GestureDetector(
            onTap: () {
              RouterClass.routerClass
                  .pushToScreenUsingWidget(const PrivacyPoliciesScreen());
            },
            child: Card(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                child: ListTile(
                  title: Text(
                    'privacy_policies'.tr(),
                    style:
                        TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          GestureDetector(
            onTap: () {
              RouterClass.routerClass
                  .pushToScreenUsingWidget(const TermsAndConditionsScreen());
            },
            child: Card(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                child: ListTile(
                  title: Text(
                    'terms_and_conditions'.tr(),
                    style:
                        TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          GestureDetector(
            onTap: () {
              RouterClass.routerClass
                  .pushToScreenUsingWidget(const ServicePoliciesScreen());
            },
            child: Card(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                child: ListTile(
                  title: Text(
                    'service_policies'.tr(),
                    style:
                        TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
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
