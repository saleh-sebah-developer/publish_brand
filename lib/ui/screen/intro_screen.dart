import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/ui/screen/login_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math' as math;

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(Slide(
        title: 'slider1_title'.tr(),
        description: 'slider1_description'.tr(),
        pathImage: 'assets/images/slider_img1.png'));
    slides.add(Slide(
        title: 'slider2_title'.tr(),
        description: 'slider2_description'.tr(),
        pathImage: 'assets/images/slider_img2.png'));
    slides.add(Slide(
        title: 'slider3_title'.tr(),
        description: 'slider3_description'.tr(),
        pathImage: 'assets/images/slider_img3.png'));
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          padding: EdgeInsets.only(bottom: 100.h, top: 47.h),
          height: 812.h,
          width: 375.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg2.png'),
                fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 98.w,
                height: 67.h,
                child: const Image(
                  image: AssetImage('assets/images/logo_app.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 77.h, top: 54.h),
                width: 304.w,
                height: 299.h,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Image.asset(
                    currentSlide.pathImage,
                    matchTextDirection: true,
                    height: 60.h,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 12.h),
                child: Text(
                  currentSlide.title,
                  style: TextStyle(
                      fontFamily: 'TajawalBold',
                      color: const Color(0xff4A4B4D),
                      fontSize: 16.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                margin: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
                child: Text(
                  currentSlide.description,
                  maxLines: 2,
                  style: TextStyle(
                      color: const Color(0xff7C7D7E),
                      fontFamily: 'TajawalRegular',
                      fontSize: 14.sp),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      backgroundColorAllSlides: Colors.white,
      renderSkipBtn: Container(
        height: 40.h,
        width: 100.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: HexColor("#E6E7EB"),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Text(
          "skip".tr(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      renderNextBtn: Container(
        height: 40.h,
        width: 100.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: HexColor("#4091AF"),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Text(
          "next".tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      renderDoneBtn: Container(
        height: 40.h,
        width: 100.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: HexColor("#4091AF"),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Text(
          "done".tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      colorActiveDot: Colors.white,
      sizeDot: 8.0.r,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      listCustomTabs: renderListCustomTabs(),
      scrollPhysics: const BouncingScrollPhysics(),
      onDonePress: () =>
          RouterClass.routerClass.pushReplacementToScreen(LoginScreen()),
    );
  }
}
