import 'dart:async';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:publish_brand/data/sp_helper.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/ui/screen/intro_screen.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:hexcolor/hexcolor.dart';

import 'home.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SpHelper>(context, listen: false).getToken();
    Timer(
      const Duration(seconds: 4),
      () => Provider.of<SpHelper>(context, listen: false).token == null
          ? RouterClass.routerClass.pushReplacementToScreen(IntroScreen())
          : RouterClass.routerClass.pushReplacementToScreen(Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            height: 812.h,
            width: 375.w,
            //TODO image splash screen in center
            decoration: BoxDecoration(
              color: HexColor('#F5F5F5'),
              image: const DecorationImage(
                  image: AssetImage('assets/images/comp.gif'),
                  fit: BoxFit.fill),
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DelayedDisplay(
                        delay: Duration(milliseconds: 800),
                        slidingBeginOffset: Offset(0.0, 10.0),
                        fadingDuration: Duration(milliseconds: 1000),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'from',
                              style: TextStyle(
                                  fontFamily: 'TajawalRegular',
                                  fontSize: 14,
                                  color: HexColor('#4091AF')),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Image(
                              height: 60.h,
                              width: 60.w,
                              image:
                              const AssetImage('assets/images/logo1.png'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Container(
            //   height: 300,
            //   width: 300,
            //   color: Colors.green,
            // ),
          ),
        ),
      ),
    );
  }
}
