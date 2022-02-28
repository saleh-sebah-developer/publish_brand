import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/home.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';


// ignore: must_be_immutable
class ContactTechnicalSupportScreen extends StatelessWidget {
  GlobalKey<FormState> contactTSFormKey = GlobalKey<FormState>();

  ContactTechnicalSupportScreen({Key key}) : super(key: key);
  openWhatsappChat(String mobileNumber) {
    launch(mobileNumber);
  }
  sendEmail(String emailAddress) {
    launch(emailAddress);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'contact_technical_support'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body:Consumer2<HomeProvider,ApiAuthProvider>(builder: (context, providerHome,providerAuth, x) {
        return Form(
          key: contactTSFormKey,
          child:  ListView(
            children: [
              SizedBox(
                height: 6.h,
              ),
              Card(
                child: ListTile(
                  onTap: (){
                    openWhatsappChat('https://wa.me/+970567802100');
                  },
                  title: Text(
                    'contact_via_whats_app_number'.tr(),
                    style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
                  ),
                  leading: Image(
                    height: 38.h,
                    width: 38.w,
                    image: const AssetImage('assets/icons/ic_whatsup.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Card(
                child: ListTile(
                  onTap: (){
                    sendEmail(
                        'mailto:sebah.sma@gmail.com?subject=this is subject from shady &body=the content email');
                  },
                  title: Text(
                    'admin@publishbrand.com',
                    style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
                  ),
                  leading: Image(
                    height: 38.h,
                    width: 38.w,
                    image: const AssetImage('assets/icons/ic_email.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Container(
                margin: EdgeInsets.only(right: 12.w, left: 12.w, top: 12.h),
                alignment: Alignment.centerRight,
                child: Text(
                  'or_through_the_following_form'.tr(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'TajawalRegular',
                      fontSize: 16.sp),
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              CustomTextField(
                controller: providerHome.nameConContactTS,
                textInputType: TextInputType.text,
                labelText: 'personan_noun'.tr(),
                labelTextHint: 'hint_personan_noun'.tr(),
                validationFun: providerAuth.validateNull,
              ),
              CustomTextField(
                controller: providerHome.mobileConContactTS,
                textInputType: TextInputType.phone,
                labelText: 'phone'.tr(),
                labelTextHint: 'hint_phone'.tr(),
                validationFun: providerAuth.validatePhone,
              ),
              CustomTextField(
                controller: providerHome.messageConContactTS,
                textInputType: TextInputType.text,
                labelText: 'message_details'.tr(),
                labelTextHint: 'hint_message_details'.tr(),
                validationFun: providerAuth.validateNull,
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
              GestureDetector(
                onTap: providerHome.btnIsEnable?() {
                  if (contactTSFormKey.currentState.validate()) {
                    providerHome.sendContactMsg(context);
                  }
                }:(){},
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 34.h),
                  margin: EdgeInsets.only(top: 85.h),
                  child: CustomButtonY(
                    labelText: 'send_message'.tr(),
                    sizeButton: 1,
                  ),
                ),
              )
            ],
          ),
        );
      }),


    );
  }
}
