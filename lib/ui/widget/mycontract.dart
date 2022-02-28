import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomMyContract extends StatelessWidget {
  String label;

  CustomMyContract({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
            ),
            const Spacer(),
            Container(
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HexColor('#4091AF'),
                ),
                child: const Icon(
                  Icons.download,
                  color: Colors.white,
                  size: 20,
                )),
            SizedBox(
              width: 4.w,
            ),
            Text(
              'loading'.tr(),
              style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'TajawalBold',
                  color: HexColor('#4091AF'),
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
