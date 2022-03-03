import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/models/get_services_details_response.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'bill_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PaymentConfirmationScreen extends StatelessWidget {
  TextEditingController loginPhoneCon = TextEditingController();
  Function function;
  Service service;

  PaymentConfirmationScreen({this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'payment_confirmation'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(right: 12.w, left: 12.w, top: 12.h),
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
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'TajawalBold',
                                  color: Colors.black)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('price'.tr() + service.title,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'TajawalRegular',
                                      color: Colors.black)),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                  service.type == 'fixed_price'
                                      ? service.price.toString() + 'sr'.tr()
                                      : service.type == 'unfixed_price'
                                          ? 'the_price_is_negotiable'.tr()
                                          : service.pointsCount.toString() +
                                              'point'.tr(),
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'TajawalBold',
                                      color: HexColor('#4091AF'))),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('estimated_time_to_implement'.tr(),
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'TajawalBold',
                                      color: Colors.black)),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                  Provider.of<HomeProvider>(context)
                                          .selectedServices
                                          .estimatedTime +
                                      'days'.tr(),
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
                      alignment: Alignment.centerRight,
                      margin:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      child: Text(
                          'please_choose_the_payment_method_suitable_for_you'
                              .tr(),
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'TajawalRegular',
                              color: Colors.black)),
                    ),
                    CustomTextField(
                      controller: loginPhoneCon,
                      textInputType: TextInputType.phone,
                      labelText: 'card_number'.tr(),
                      labelTextHint: '5863 - 2558 - 9632 - 5547',
                      validationFun: function,
                    ),
                    CustomTextField(
                      controller: loginPhoneCon,
                      textInputType: TextInputType.phone,
                      labelText: 'password_cvv'.tr(),
                      labelTextHint: '6 - 8 - 1',
                      validationFun: function,
                    ),
                    CustomTextField(
                      controller: loginPhoneCon,
                      textInputType: TextInputType.phone,
                      labelText: 'expiry_date'.tr(),
                      labelTextHint: 'dd/mm',
                      validationFun: function,
                    ),
                    CustomTextField(
                      controller: loginPhoneCon,
                      textInputType: TextInputType.phone,
                      labelText: 'cardholder_name'.tr(),
                      labelTextHint: 'hint_cardholder_name'.tr(),
                      validationFun: function,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        RouterClass.routerClass
                            .pushToScreenUsingWidget(BillScreen(
                          service:
                              Provider.of<HomeProvider>(context, listen: false)
                                  .selectedServices,
                        ));
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.w, vertical: 34.w),
                        margin: EdgeInsets.only(top: 85.h),
                        child: CustomButtonY(
                          labelText: 'continuation'.tr(),
                          sizeButton: 1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
