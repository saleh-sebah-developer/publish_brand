import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  String labelText;
  String labelContent;
  String labelTextHint;
  TextEditingController controller;
  Function validationFun;
  TextInputType textInputType;

  CustomTextField(
      {Key key,
      this.labelText,
      this.labelContent,
      this.labelTextHint,
      this.controller,
      this.validationFun,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 20.w, right: 20.w, top: 14.h, bottom: 10.h),
      margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            labelText,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'TajawalRegular',
                fontSize: 16.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          TextFormField(
            controller: controller,
            validator: (v) => validationFun(v),
            keyboardType: textInputType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: (labelTextHint),
              labelText: labelContent,
              hintStyle: TextStyle(
                  color: HexColor('#9DA1A2'),
                  fontFamily: 'TajawalRegular',
                  fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
