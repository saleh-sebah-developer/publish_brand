import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/ui/screen/policies.dart';
import 'package:publish_brand/ui/widget/custom_button3.dart';
import 'package:publish_brand/ui/widget/custom_button_n.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  String typeUser = 'user';

  SignUpScreen({this.typeUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'registration'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Container(
          margin: EdgeInsets.only(top: 10.h),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg_all.png'),
                fit: BoxFit.fill),
          ),
          child: Consumer<ApiAuthProvider>(builder: (context, provider, x) {
            provider.typeUser = typeUser;
            return Form(
              key: signUpFormKey,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 12.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  provider.changeUserType();
                                },
                                child: provider.typeUser == 'user'
                                    ? CustomButton3(
                                        labelText: 'individual'.tr(),
                                        sizeButton: 2.5,
                                      )
                                    : CustomButtonN(
                                        labelText: 'individual'.tr(),
                                        sizeButton: 2.5,
                                      ),
                              ),
                              SizedBox(
                                width: 22.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  provider.changeUserType();
                                },
                                child: provider.typeUser == 'company'
                                    ? CustomButton3(
                                        labelText: 'company_institution'.tr(),
                                        sizeButton: 2.5,
                                      )
                                    : CustomButtonN(
                                        labelText: 'company_institution'.tr(),
                                        sizeButton: 2.5,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        CustomTextField(
                          controller: provider.nameConSignUp,
                          textInputType: TextInputType.text,
                          labelText: provider.typeUser == 'user'
                              ? 'personan_noun'.tr()
                              : 'company_institution_name'.tr(),
                          labelTextHint: provider.typeUser == 'user'
                              ? 'hint_personan_noun'.tr()
                              : 'hint_company_institution_name'.tr(),
                          validationFun: provider.validateNull,
                        ),
                        CustomTextField(
                          controller: provider.mobileConSignUp,
                          textInputType: TextInputType.phone,
                          labelText: 'phone'.tr(),
                          labelTextHint: 'hint_phone'.tr(),
                          validationFun: provider.validatePhone,
                        ),
                        provider.typeUser == 'company'
                            ? CustomTextField(
                                controller: provider.phoneConSignUp,
                                textInputType: TextInputType.phone,
                                labelText: 'company_phone_number'.tr(),
                                labelTextHint: 'hint_company_phone_number'.tr(),
                                validationFun: provider.validatePhone,
                              )
                            : Container(),
                        CustomTextField(
                          controller: provider.emailConSignUp,
                          textInputType: TextInputType.emailAddress,
                          labelText: 'email'.tr(),
                          labelTextHint: 'hint_email'.tr(),
                          validationFun: provider.typeUser != 'user'
                              ? provider.validateEmail
                              : provider.validate,
                        ),
                        CustomTextField(
                          controller: provider.passwordConSignUp,
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'password'.tr(),
                          labelTextHint: 'hint_password'.tr(),
                          validationFun: provider.validateNull,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          child: SwitchListTile(
                              title: Text(
                                'agree_terms_switch'.tr(),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontFamily: 'TajawalRegular',
                                    fontSize: 14.sp,
                                    color: Colors.black),
                              ),
                              subtitle: GestureDetector(
                                onTap: () {
                                  RouterClass.routerClass
                                      .pushToScreenUsingWidget(
                                          PoliciesScreen());
                                },
                                child: Text(
                                  'policies_click_here'.tr(),
                                  style: TextStyle(color: HexColor('#4091AF')),
                                ),
                              ),
                              value: provider.agreeTerms,
                              onChanged: (value) {
                                provider.changeAgreeTerms();
                              }),
                        ),
                        provider.btnIsEnable == false
                            ? SizedBox(
                                height: 40.h,
                                width: 40.w,
                                child: Center(
                                  child: Lottie.asset(
                                      'assets/animations/progress1.json'),
                                ))
                            : Container(),
                        const Spacer(),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 34.h),
                          // margin: EdgeInsets.only(top: 85.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: provider.btnIsEnable
                                    ? () {
                                        if (signUpFormKey.currentState
                                            .validate()) {
                                          provider.SignUpUsers(context);
                                        }
                                      }
                                    : () {},
                                child: CustomButtonY(
                                  labelText: 'create_an_account'.tr(),
                                  sizeButton: 2.5,
                                ),
                              ),
                              SizedBox(
                                width: 22.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  RouterClass.routerClass.popScreen();
                                },
                                child: CustomButtonN(
                                  labelText: 'login'.tr(),
                                  sizeButton: 2.5,
                                ),
                              ),
                            ],
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
      }),
    );
  }
}
