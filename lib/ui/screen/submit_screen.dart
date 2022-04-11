import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/models/get_services_details_response.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/payment_confirmation.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SubmitService extends StatelessWidget {
  Function function;
  GlobalKey<FormState> submitServiceFormKey = GlobalKey<FormState>();
  Service service;

  SubmitService({this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'submit_service_request'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Consumer2<HomeProvider,ApiAuthProvider>(builder: (context, provider,providerApi, x) {
          return Form(
            key: submitServiceFormKey,
            child: Column(
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
                          Flexible(
                            child: Text(
                                'price'.tr() + service.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily:
                                    'TajawalRegular',
                                    color: Colors.black)),
                          ),
                          // Text('price'.tr()+service.title,
                          //     style: TextStyle(
                          //         fontSize: 14.sp,
                          //         fontFamily: 'TajawalRegular',
                          //         color: Colors.black)),
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
                          Text(Provider.of<HomeProvider>(context).selectedServices.estimatedTime??'estimated'+'days'.tr(),
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
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Text('once_payment_completed'.tr(),
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'TajawalRegular',
                          color: Colors.black)),
                ),
                CustomTextField(
                  controller: provider.serviceDetailsConSubmitService,
                  textInputType: TextInputType.text,
                  labelText: 'details_service_requested_by_you'.tr(),
                  labelTextHint: 'hint_details_service_requested_by_you'.tr(),
                  validationFun: providerApi.validateNull,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (submitServiceFormKey.currentState
                        .validate()){
                      RouterClass.routerClass
                          .pushToScreenUsingWidget(PaymentConfirmationScreen(
                        service: Provider.of<HomeProvider>(context, listen: false)
                            .selectedServices,
                      ));
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
                    margin: EdgeInsets.only(top: 85.h),
                    child: CustomButtonY(
                      labelText: 'continuation'.tr(),
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
