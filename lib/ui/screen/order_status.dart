import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/ui/screen/home.dart';
import 'package:publish_brand/ui/widget/custom_button_n.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'order_status'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          padding: EdgeInsets.only(top: 100.h),
          child: Column(
            children: [
              Image(
                  height: 268.h,
                  width: 251.w,
                  image: AssetImage('assets/images/done_img.png')),
              Text('our_end'.tr(),
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontFamily: 'TajawalBold',
                      color: HexColor('#4091AF'))),
              SizedBox(
                height: 12.w,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                child: Text('the_request_has_been_submitted_successfully'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'TajawalBold',
                        color: Colors.black)),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //
              //   ],
              // ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                child: Text('review_your_request'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'TajawalRegular',
                        color: Colors.black)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                child: Text(
                    'thank_you_for_your_kind_cooperation_and_patience'.tr(),
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: 'TajawalBold',
                        color: Colors.black)),
              ),
              Visibility(
                visible: false,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('to_download_and_review_the_invoice'.tr(),
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'TajawalRegular',
                              color: Colors.black)),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text('press_here'.tr(),
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'TajawalBold',
                              color: HexColor('#4091AF'))),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  RouterClass.routerClass.pushToScreenUsingWidget(const Home());
                },
                child: Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 34.h),
                  margin: EdgeInsets.only(top: 85.h),
                  child: CustomButtonN(
                    labelText: 'back_to_the_home_page'.tr(),
                    sizeButton: 1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
