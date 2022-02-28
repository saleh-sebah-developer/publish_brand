import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/ui/screen/activation_code_screen.dart';
import 'package:publish_brand/ui/widget/custom_button3.dart';
import 'package:publish_brand/ui/widget/custom_button_n.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgetPasswordScreen extends StatelessWidget {
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'restore_password'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30.h),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg_all.png'), fit: BoxFit.fill),
        ),
        child: Consumer<ApiAuthProvider>(builder: (context, provider, x) {
          return  Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                       provider.changePasswordRecoveryOption();
                      },
                      child: provider.passwordRecoveryOption == 1
                          ? CustomButton3(
                        labelText: 'phone'.tr(),
                        sizeButton: 2.5,
                      )
                          : CustomButtonN(
                        labelText: 'phone'.tr(),
                        sizeButton: 2.5,
                      ),
                    ),
                    SizedBox(
                      width: 22.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        provider.changePasswordRecoveryOption();
                      },
                      child:  provider.passwordRecoveryOption == 2
                          ? CustomButton3(
                        labelText: 'email'.tr(),
                        sizeButton: 2.5,
                      )
                          : CustomButtonN(
                        labelText: 'email'.tr(),
                        sizeButton: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: forgetPasswordFormKey,
                child:   provider.passwordRecoveryOption == 1
                  ? CustomTextField(
                controller: provider.mobileConForgetPassword,
                textInputType: TextInputType.phone,
                labelText: 'phone'.tr(),
                labelTextHint: 'hint_phone2'.tr(),
                validationFun: provider.validatePhone,
              )
                  : CustomTextField(
                controller: provider.emailConForgetPassword,
                textInputType: TextInputType.emailAddress,
                labelText: 'email'.tr(),
                labelTextHint: 'hint_email2'.tr(),
                validationFun: provider.validateEmail,
              ),),
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
                onTap: provider.btnIsEnable?() {
                  if (forgetPasswordFormKey.currentState.validate()) {
                     provider.forgotPassword(context);
                  }
                }:(){},
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 34.h),
                  margin: EdgeInsets.only(top: 85.h),
                  child: CustomButtonY(
                    labelText: 'restore_password'.tr(),
                    sizeButton: 1,
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
