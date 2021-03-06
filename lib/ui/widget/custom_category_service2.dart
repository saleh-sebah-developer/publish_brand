import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class CustomCategoryService2 extends StatelessWidget {
  String iconData;
  String label;
  String labelSub;

  CustomCategoryService2({Key key, this.label, this.labelSub, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          iconData != null
              ? CachedNetworkImage(
                  height: 24.h,
                  width: 24.w,
                  imageUrl: iconData,
                )
              : Image(
                  height: 24.h,
                  width: 24.w,
                  image: const AssetImage('assets/icons/ic_3dcube.png'),
                ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontFamily: 'TajawalRegular'),
          ),
          Text(
            labelSub,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: HexColor("#4091AF"),
                fontSize: 14.sp,
                fontFamily: 'TajawalRegular'),
          ),
        ],
      ),
    );
  }
}
