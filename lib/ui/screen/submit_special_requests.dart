import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'order_status_special.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';


// ignore: must_be_immutable
class SubmitSpecialRequestsScreen extends StatelessWidget {
  GlobalKey<FormState> submitSpecialRequestsFormKey = GlobalKey<FormState>();


  SubmitSpecialRequestsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'submit_special_requests'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body:
      Container(
        child: Consumer2<HomeProvider,ApiAuthProvider>(builder: (context, providerHome,providerAut, x) {
          return  Form(
            key: submitSpecialRequestsFormKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: providerHome.projectNameConSubmitSpecialRequests,
                  textInputType: TextInputType.text,
                  labelText: 'project_name'.tr(),
                  labelTextHint: 'hint_project_name'.tr(),
                  validationFun: providerAut.validateNull,
                ),
                CustomTextField(
                  controller: providerHome.projectDetailsConSubmitSpecialRequests,
                  textInputType: TextInputType.emailAddress,
                  labelText: 'project_details'.tr(),
                  labelTextHint: 'hint_project_details'.tr(),
                  validationFun:  providerAut.validateNull,
                ),
                providerHome.btnIsEnable == false
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
                  onTap: providerHome.btnIsEnable? () {
                    if (submitSpecialRequestsFormKey.currentState.validate()) {
                      providerHome.requestSpecialService(context);
                    }
                  }:(){},
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 34.h),
                    margin: EdgeInsets.only(top: 85.h),
                    child: CustomButtonY(
                      labelText: 'submission_of_the_application'.tr(),
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
