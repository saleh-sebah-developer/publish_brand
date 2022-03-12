import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:lottie/lottie.dart';

class DetailsPackageScreen extends StatelessWidget {
  String _detailsPackage;

  DetailsPackageScreen(this._detailsPackage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'details'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: ListView(
        children: [
          _detailsPackage.isEmpty
              ? Center(
                  child: Lottie.asset('assets/animations/empty2.json'),
                )
              : Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Text(
                    _detailsPackage,
                    style: TextStyle(
                        fontFamily: 'TajawalRegular', fontSize: 14.sp),
                  ),
                ),
        ],
      ),
    );
  }
}
