import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/ui/screen/forget_password_screen.dart';
import 'package:publish_brand/ui/screen/home.dart';
import 'package:publish_brand/ui/screen/signup_screen.dart';
import 'package:publish_brand/ui/widget/custom_button_n.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        // Try removing opacity to observe the lack of a blur effect and of sliding content.
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'login'.tr(),
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
          return Form(
            key: loginFormKey,
            child: ListView(
              children: [
                CustomTextField(
                  controller: provider.mobileConLogin,
                  textInputType: TextInputType.phone,
                  labelText: 'phone'.tr(),
                  labelTextHint: 'hint_phone'.tr(),
                  validationFun: provider.validatePhone,
                ),
                CustomTextField(
                  controller: provider.passwordConLogin,
                  textInputType: TextInputType.visiblePassword,
                  labelText: 'password'.tr(),
                  labelTextHint: 'hint_password'.tr(),
                  validationFun: provider.validateNull,
                ),
                GestureDetector(
                  onTap: () {
                    RouterClass.routerClass
                        .pushToScreenUsingWidget(ForgetPasswordScreen());
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: Text(
                      'forget_password'.tr(),
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: 14.sp, fontFamily: 'TajawalBold'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    RouterClass.routerClass
                        .pushToScreenUsingWidget(SignUpScreen(typeUser: 'user',));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image(
                          height: 24.h,
                          width: 24.w,
                          image:
                              const AssetImage('assets/icons/ic_profile.png'),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'individual_account'.tr(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 14.sp, fontFamily: 'TajawalBold'),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    RouterClass.routerClass
                        .pushToScreenUsingWidget(SignUpScreen(typeUser: 'company',));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image(
                          height: 24.h,
                          width: 24.w,
                          image:
                              const AssetImage('assets/icons/ic_company.png'),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'company_account'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp, fontFamily: 'TajawalBold'),
                        ),
                      ],
                    ),
                  ),
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
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 260),
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 34.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: provider.btnIsEnable
                            ? () {
                                if (loginFormKey.currentState.validate()) {
                                  provider.LoginForUsers(context);
                                }
                              }
                            : () {},
                        child: CustomButtonY(
                          labelText: 'login'.tr(),
                          sizeButton: 2.5,
                        ),
                      ),
                      SizedBox(
                        width: 22.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            RouterClass.routerClass
                                .pushReplacementToScreen(const Home());
                          },
                          child: CustomButtonN(
                            labelText: 'login_guest'.tr(),
                            sizeButton: 2.5,
                          )),
                    ],
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
