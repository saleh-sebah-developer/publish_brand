import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/change_password_screen.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {

  ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<ApiAuthProvider>(context,listen: false).profile(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'my_personal_information'.tr(),
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
                key: profileFormKey,

                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: provider.nameConProfile,
                            textInputType: TextInputType.text,
                            labelText: provider.typeUser == 'user'
                                ? 'personan_noun'.tr()
                                : 'company_institution_name'.tr(),
                            labelTextHint: 'hint_personan_noun'.tr(),
                            validationFun: provider.validateNull,
                          ),
                          CustomTextField(
                            controller: provider.mobileConProfile,
                            textInputType: TextInputType.phone,
                            labelText: 'phone'.tr(),
                            labelTextHint: 'hint_phone'.tr(),
                            validationFun: provider.validatePhone,
                          ),
                          provider.typeUser == 'company'
                              ? CustomTextField(
                            controller: provider.phoneConProfile,
                            textInputType: TextInputType.phone,
                            labelText: 'company_phone_number'.tr(),
                            labelTextHint: 'hint_company_phone_number'.tr(),
                            validationFun: provider.validatePhone,
                          )
                              : Container(),
                          CustomTextField(
                            controller: provider.emailConProfile,
                            textInputType: TextInputType.emailAddress,
                            labelText: 'email'.tr(),
                            labelTextHint: 'hint_email'.tr(),
                            validationFun: provider.validateEmail,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 14.h, bottom: 20.h),
                            margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 4.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'password'.tr(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'TajawalRegular',
                                      fontSize: 16.sp),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    RouterClass.routerClass
                                        .pushToScreenUsingWidget(ChangePasswordScreen());
                                  },
                                  child: ListTile(
                                    title: Text(
                                      '×××××××××××××××××××××',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily: 'TajawalBold',
                                          color: HexColor('#9DA1A2')),
                                    ),
                                    trailing: Image(
                                      height: 24.h,
                                      width: 24.w,
                                      image: const AssetImage('assets/icons/ic_edit.png'),
                                    ),
                                  ),
                                ),
                              ],
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
                            padding:
                            EdgeInsets.symmetric(horizontal: 22.w, vertical: 34.h),
                            child: GestureDetector(
                              onTap: provider.btnIsEnable? () {
                                if (profileFormKey.currentState.validate()) {
                                  Provider.of<ApiAuthProvider>(context, listen: false)
                                      .editProfile(context);
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
