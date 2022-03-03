import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'change_password'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: LayoutBuilder(
        builder: (context,constraint) {
          return Container(
            margin: EdgeInsets.only(top: 10.h),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_all.png'), fit: BoxFit.fill),
            ),
            child: Consumer<ApiAuthProvider>(builder: (context, provider, x) {
              return Form(
                key: changePasswordFormKey,


                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: provider.passwordConOldChangePassword,
                            textInputType: TextInputType.visiblePassword,
                            labelText: 'old_password'.tr(),
                            labelTextHint: 'hint_old_password'.tr(),
                            validationFun: provider.validateNull,
                          ),
                          CustomTextField(
                            controller: provider.passwordConNewChangePassword,
                            textInputType: TextInputType.visiblePassword,
                            labelText: 'new_password'.tr(),
                            labelTextHint: 'hint_new_password'.tr(),
                            validationFun: provider.validateNull,
                          ),
                          CustomTextField(
                            controller: provider.confirmPasswordConNewChangePassword,
                            textInputType: TextInputType.visiblePassword,
                            labelText: 'confirm_new_password'.tr(),
                            labelTextHint: 'hint_confirm_new_password'.tr(),
                            validationFun: provider.validateConfirmedPassword2,
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
                            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 34.h),
                            child: GestureDetector(
                              onTap: provider.btnIsEnable? () {
                                if (changePasswordFormKey.currentState.validate()) {
                                  Provider.of<ApiAuthProvider>(context, listen: false).changePassword(context);
                                }
                              }:(){},
                              child: CustomButtonY(
                                labelText: 'save_changes'.tr(),
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
      ),
    );
  }
}
