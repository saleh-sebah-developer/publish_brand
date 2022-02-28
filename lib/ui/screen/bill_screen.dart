import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'order_status.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:publish_brand/models/get_services_details_response.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class BillScreen extends StatelessWidget {
  GlobalKey<FormState> billFormKey = GlobalKey<FormState>();
  Service service;
  BillScreen({this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'bill'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Consumer<HomeProvider>(builder: (context, provider, x) {
          return Form(
            key: billFormKey,
            child:  Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 12.w, left: 12.w, top: 12.h),
                  width: MediaQuery.of(context).size.width,
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(service.title,
                          style:  TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'TajawalBold',
                              color: Colors.black)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('price'.tr()+Provider.of<HomeProvider>(context).selectedServices.title,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'TajawalRegular',
                                  color: Colors.black)),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                              service.type == 'fixed_price'?
                              service.price
                                  .toString() +
                                  'sr'.tr():
                              service.type == 'unfixed_price'?
                              'the_price_is_negotiable'.tr():
                              service.pointsCount.toString() + 'point'.tr(),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'TajawalBold',
                                  color: HexColor('#4091AF'))),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: 4.w, left: 4.w, top: 12.h, bottom: 12.h),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('pay_by'.tr()+'فيزا ',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'TajawalBold',
                              color: Colors.black)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('****-****-****-',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'TajawalRegular',
                                  color: Colors.black)),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text('5863',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'TajawalRegular',
                                  color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  controller: provider.discountCodeConSubmitService,
                  textInputType: TextInputType.text,
                  labelText: 'discount_code'.tr(),
                  labelTextHint: 'hint_discount_code'.tr(),
                  validationFun: provider.validate,
                ),
                provider.btnIsEnable == false
                    ? SizedBox(
                    height: 40.h,
                    width: 40.w,
                    child: Center(
                      child:
                      Lottie.asset('assets/animations/progress1.json'),
                    ))
                    : Container(),
                const Spacer(),
                GestureDetector(
                  onTap:  provider.btnIsEnable?() {
                    if (billFormKey.currentState.validate()) {
                      provider.requestService(context);
                    }
                    //RouterClass.routerClass.pushToScreenUsingWidget(OrderStatus());
                  }:(){},
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 34.h),
                    margin: EdgeInsets.only(top: 85.h),
                    child: CustomButtonY(
                      labelText: 'confirm_and_send_the_request'.tr(),
                      sizeButton: 1,
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
