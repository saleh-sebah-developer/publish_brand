import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/data/sp_helper.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/points_service.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/my_point.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class LoyaltyPointsScreen extends StatefulWidget {
  const LoyaltyPointsScreen({Key key}) : super(key: key);

  @override
  State<LoyaltyPointsScreen> createState() => _LoyaltyPointsScreenState();
}

class _LoyaltyPointsScreenState extends State<LoyaltyPointsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SpHelper>(context, listen: false).token != null?
    Provider.of<HomeProvider>(context, listen: false).getMyPoints(context):(){};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'loyalty_points'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: Column(
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'my_available_points'.tr(),
                      style:
                          TextStyle(fontSize: 18.sp, fontFamily: 'TajawalBold'),
                    ),
                    subtitle: Text(
                      'you_can_redeem_your_points'.tr(),
                      style: TextStyle(
                          fontSize: 16.sp, fontFamily: 'TajawalRegular'),
                    ),
                    trailing: Text(
                      'number_points'.tr() +
                              '\n' +
                              Provider.of<HomeProvider>(context, listen: false)
                                  .numPoints ??
                          '0',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'TajawalBold',
                          color: HexColor('#4091AF')),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      RouterClass.routerClass.pushToScreenUsingWidget(
                          const PointsServicesScreen());
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        child: CustomButtonY(
                          sizeButton: 1,
                          labelText: 'replacing'.tr(),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Provider.of<HomeProvider>(context).points == null
              ? Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Lottie.asset('assets/animations/progress1.json'),
                  ),
                )
              : Provider.of<HomeProvider>(context).points.isEmpty
                  ? Center(
                      child: Container(
                        child: Lottie.asset('assets/animations/empty2.json'),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height / 1.4.h,
                      child: ListView.builder(
                          padding: EdgeInsets.all(2.h),
                          scrollDirection: Axis.vertical,
                          itemCount:
                              Provider.of<HomeProvider>(context).points.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: CustomMyPoints(
                                date: 'dfs',
                                //Provider.of<HomeProvider>(context).points[index].createdAt
                                point: Provider.of<HomeProvider>(context)
                                    .points[index]
                                    .points
                                    .toString(),
                              ),
                            );
                          }),
                    ),
        ],
      ),
    );
  }
}
