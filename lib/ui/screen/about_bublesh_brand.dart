import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:lottie/lottie.dart';

class AboutBubleshBrandScreen extends StatefulWidget {

  @override
  State<AboutBubleshBrandScreen> createState() => _AboutBubleshBrandScreenState();
}

class _AboutBubleshBrandScreenState extends State<AboutBubleshBrandScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).pageDetails(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'about_bublesh_brand'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 6.h,
          ),
          Image(
            height: 67.h,
            width: 98.w,
            image: const AssetImage('assets/images/logo_app.png'),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child:
            Provider.of<HomeProvider>(context).pageText==null?
            SizedBox(
                height: 40.h,
                width: 40.w,
                child: Center(
                  child:
                  Lottie.asset('assets/animations/progress1.json'),
                )):
            Provider.of<HomeProvider>(context).pageText.isEmpty?
            Center(child:  Lottie.asset('assets/animations/empty2.json'),):
            Text(
              Provider.of<HomeProvider>(context).pageText,
              style: TextStyle(fontFamily: 'TajawalRegular', fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
