import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/ui/screen/submit_special_requests.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:lottie/lottie.dart';

class SpecialRequestsScreen extends StatefulWidget {
  const SpecialRequestsScreen({Key key}) : super(key: key);

  @override
  State<SpecialRequestsScreen> createState() => _SpecialRequestsScreenState();
}

class _SpecialRequestsScreenState extends State<SpecialRequestsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).pageDetails(10);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<HomeProvider>(context, listen: false).clearPagetext();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white.withOpacity(0.5),
          middle: Text(
            'special_requests'.tr(),
            style: TextStyle(
                color: HexColor("#4091AF"),
                fontSize: 16.sp,
                fontFamily: 'TajawalBold'),
          ),
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      child: Provider.of<HomeProvider>(context).pageText == null
                          ? SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: Center(
                                child: Lottie.asset(
                                    'assets/animations/progress1.json'),
                              ))
                          : Provider.of<HomeProvider>(context).pageText.isEmpty
                              ? Center(
                                  child: Lottie.asset(
                                      'assets/animations/empty2.json'),
                                )
                              : Text(
                                  Provider.of<HomeProvider>(context).pageText,
                                  style: TextStyle(
                                      fontFamily: 'TajawalRegular',
                                      fontSize: 14.sp),
                                ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        RouterClass.routerClass.pushToScreenUsingWidget(
                            SubmitSpecialRequestsScreen());
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.w, vertical: 34.h),
                        margin: EdgeInsets.only(top: 85.h),
                        child: CustomButtonY(
                          labelText: 'continuation'.tr(),
                          sizeButton: 1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
