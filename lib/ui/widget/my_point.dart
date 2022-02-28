import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomMyPoints extends StatelessWidget {
  String date;
  String point;

  CustomMyPoints({Key key, this.date, this.point}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          children: [
            Text(
              date,
              style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
            ),
            const Spacer(),
            Text(
              point,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'TajawalRegular',
                  color: HexColor('#4DB871'),
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
