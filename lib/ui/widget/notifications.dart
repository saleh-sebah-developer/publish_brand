import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable, must_be_immutable
class CustomNotifications extends StatelessWidget {
  String title;
  String time;
  String des;

  CustomNotifications({Key key, this.title, this.time, this.des})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 4.w, left: 4.w, top: 12.h),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(title??'',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'TajawalBold',
                              color: Colors.black)),
                      const Spacer(),
                      Text(time??'',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'TajawalRegular',
                              color: Colors.black)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  child: Text(des??'',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'TajawalRegular',
                          color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
