import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';


// ignore: must_be_immutable
class ActivationCodeScreen extends StatefulWidget {
  String mobile = '';

  ActivationCodeScreen(this.mobile, {Key key}) : super(key: key);

  @override
  State<ActivationCodeScreen> createState() => _ActivationCodeScreenState();
}

class _ActivationCodeScreenState extends State<ActivationCodeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiAuthProvider>(context, listen: false).mobileVerify=widget.mobile;
  }

  String codeVerify = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'activation_code'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg2.png'), fit: BoxFit.fill),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 60.h),
          child: Column(
            children: [
              Text(
                'the_activation_code_has_been_sent_to'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalRegular'),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                widget.mobile,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'TajawalBold',
                    color: HexColor('#4091AF')),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'Please_enter_the_code_in_the_appropriate_place'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalRegular'),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
                child: PinCodeTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  appContext: context,
                  length: 4,
                  onChanged: (value) {},
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5.r),
                    fieldHeight: 53.h,
                    fieldWidth: 53.w,
                    activeFillColor: Colors.white,
                    inactiveColor: Colors.red,
                    selectedColor: Colors.grey,
                    activeColor: Colors.orange,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white10,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {
                    codeVerify = v;
                    print("Completed " + v);
                    // Provider.of<ApiAuthProvider>(context, listen: false).checkCode(v);
                  },
                ),
              ),
              Text(
                'the_code_did_not_arrive'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalRegular'),
              ),
              SizedBox(
                height: 5.h,
              ),
              GestureDetector(
                onTap: Provider.of<ApiAuthProvider>(context).textIsEnable? () {
                  Provider.of<ApiAuthProvider>(context, listen: false)
                      .reSendCode(context);
                }:(){},
                child: Text(
                  'send_again'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
                ),
              ),
              Provider.of<ApiAuthProvider>(context).btnIsEnable == false
                  ? SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: Center(
                    child:
                    Lottie.asset('assets/animations/progress1.json'),
                  ))
                  : Container(),
              Provider.of<ApiAuthProvider>(context).textIsEnable == false
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
                  onTap:  Provider.of<ApiAuthProvider>(context).btnIsEnable? () {
                    Provider.of<ApiAuthProvider>(context, listen: false)
                        .checkCode(context,codeVerify);
                  }:(){},
                  child: CustomButtonY(
                    labelText: 'confirm'.tr(),
                    sizeButton: 1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
