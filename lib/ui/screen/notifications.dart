import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/widget/notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false)
        .getMyNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white.withOpacity(0.5),
          middle: Text(
            'notifications'.tr(),
            style: TextStyle(
                color: HexColor("#4091AF"),
                fontSize: 16.sp,
                fontFamily: 'TajawalBold'),
          ),
        ),
        body: Provider.of<HomeProvider>(context).listNotifications == null
            ? Center(
                child: Container(
                  height: 50,
                  width: 50,
                  child: Lottie.asset('assets/animations/progress1.json'),
                ),
              )
            : Provider.of<HomeProvider>(context).listNotifications.isEmpty
                ? Center(
                    child: Container(
                      child: Lottie.asset('assets/animations/empty2.json'),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(2.h),
                    scrollDirection: Axis.vertical,
                    itemCount: Provider.of<HomeProvider>(context)
                        .listNotifications
                        .length,
                    itemBuilder: (context, index) {
                      return CustomNotifications(
                        title: Provider.of<HomeProvider>(context)
                            .listNotifications[index]
                            .title,
                        time: Provider.of<HomeProvider>(context)
                            .listNotifications[index]
                            .createdAt
                            .substring(11, 16),
                        des: Provider.of<HomeProvider>(context)
                            .listNotifications[index]
                            .message,
                      );
                    }));
  }
}
