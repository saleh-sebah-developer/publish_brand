import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/models/get_packages_response.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'order_status_package.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class PaymentConfirmation1Screen extends StatefulWidget {
  String title;
  String iconData;
  List<PackagesProperties> packagesProperties;
  String price;
  String monthsCount;
  String package_id;
  GlobalKey<FormState> PaymentConfirmation1FormKey = GlobalKey<FormState>();
  File file;

  PaymentConfirmation1Screen(this.title, this.iconData, this.packagesProperties,
      this.price, this.monthsCount, this.package_id);

  @override
  State<PaymentConfirmation1Screen> createState() =>
      _PaymentConfirmation1ScreenState();
}

class _PaymentConfirmation1ScreenState
    extends State<PaymentConfirmation1Screen> {
  TextEditingController loginPhoneCon = TextEditingController();
  Function function;
  bool isClick = false;

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
        return Consumer2<HomeProvider, ApiAuthProvider>(
            builder: (context, providerHome, providerAut, x) {
          return Form(
            key: widget.PaymentConfirmation1FormKey,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ExpansionTile(
                              title: Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 16.sp, fontFamily: 'TajawalBold'),
                              ),
                              leading: Container(
                                  padding: EdgeInsets.all(4.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: HexColor('#145366'),
                                  ),
                                  child: widget.iconData != null
                                      ? CachedNetworkImage(
                                          height: 24.h,
                                          width: 24.w,
                                          imageUrl: widget.iconData,
                                        )
                                      : Image(
                                          height: 24.h,
                                          width: 24.w,
                                          image: const AssetImage(
                                              'assets/icons/ic_brush.png'),
                                        )),
                              trailing: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 40,
                              ),
                              children: [
                                for (int i = 0;
                                    i < widget.packagesProperties.length;
                                    i++)
                                  ListTile(
                                    // ignore: prefer_const_constructors
                                    title: Text(
                                      widget.packagesProperties[i].title,
                                    ),
                                    leading: Image(
                                      height: 24.h,
                                      width: 24.w,
                                      image: const AssetImage(
                                          'assets/icons/ic_spark.png'),
                                    ),
                                    minLeadingWidth: 10,
                                  ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 2.h),
                                  child: Text(
                                    widget.price +
                                        ' / ' +
                                        widget.monthsCount +
                                        'month'.tr(),
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontFamily: 'TajawalBold'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
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
                      providerHome.btnIsEnable == false
                          ? SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: Center(
                                child: Lottie.asset(
                                    'assets/animations/progress1.json'),
                              ))
                          : Container(),
                      const Spacer(),
                      GestureDetector(
                        onTap: providerHome.btnIsEnable
                            ? () {
                                providerHome.requestPackages(
                                    context, providerHome.platformFile);
                                /*
                      if (widget.PaymentConfirmation1FormKey.currentState.validate()) {
                        providerHome.requestPackages(context);
                      }
                      */
                              }
                            : () {},
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 34.w),
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
        });
      }),
    );
  }
}
