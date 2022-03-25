import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/data/sp_helper.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/main.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/login_screen.dart';
import 'package:publish_brand/ui/screen/policies.dart';
import 'package:publish_brand/ui/screen/profile_screen.dart';
import 'package:publish_brand/ui/screen/support_and_help.dart';
import '../../providers/AppProvider.dart';
import 'about_bublesh_brand.dart';
import 'loyalty_points.dart';
import 'my_bills_screen.dart';
import 'my_contract.dart';
import 'my_packages_and_subscriptions.dart';
import 'notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).checkInternetConnection();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        Provider.of<AppProvider>(context, listen: false)
            .checkInternetConnection(result: result);
      });
    });
    InternetConnectionChecker().onStatusChange.listen((status) {
      bool hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        Provider.of<AppProvider>(context, listen: false)
            .checkInternetConnection(hasInternet: hasInternet);
      });
    });
    Provider.of<SpHelper>(context, listen: false).getToken != null
        ? Provider.of<ApiAuthProvider>(context, listen: false).profile(context)
        : () {};
    Provider.of<SpHelper>(context, listen: false).getToken != null
        ? Provider.of<HomeProvider>(context, listen: false).getMyPoints(context)
        : () {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'more'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 12.w,
              left: 12.w,
              top: 16.h,
            ),
            child: Text(
              'my_personal_information'.tr(),
              style: const TextStyle(
                  color: Colors.black, fontFamily: 'TajawalRegular'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                  margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            Provider.of<SpHelper>(context, listen: false)
                                        .token ==
                                    null
                                ? 'new_user'.tr()
                                : Provider.of<ApiAuthProvider>(context,
                                        listen: false)
                                    .currentUser
                                    .name??" ",
                            style: const TextStyle(
                                color: Colors.black, fontFamily: 'TajawalBold'),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            //-------------
                            Provider.of<SpHelper>(context, listen: false)
                                        .token ==
                                    null
                                ? 'loyalty_points'.tr() + '0' + 'point'.tr()
                                : 'loyalty_points'.tr() +
                                    ' ' +
                                    Provider.of<HomeProvider>(context,
                                            listen: false)
                                        .numPoints
                                        .toString() +
                                    'point'.tr(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'TajawalRegular'),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Provider.of<SpHelper>(context, listen: false).token ==
                                  null
                              ? Provider.of<ApiAuthProvider>(context,
                                      listen: false)
                                  .checkToken(context)
                              : RouterClass.routerClass
                                  .pushToScreenUsingWidget(ProfileScreen());
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22.w, vertical: 12.h),
                            child: Image(
                              height: 28.h,
                              width: 28.w,
                              image:
                                  const AssetImage('assets/icons/ic_edit.png'),
                            )),
                      ),
                    ],
                  )),
              GestureDetector(
                onTap: () {
                  Provider.of<SpHelper>(context, listen: false).token == null
                      ? Provider.of<ApiAuthProvider>(context, listen: false)
                          .checkToken(context)
                      : RouterClass.routerClass
                          .pushToScreenUsingWidget(const LoyaltyPointsScreen());
                },
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Image(
                          height: 24.h,
                          width: 24.w,
                          image:
                              const AssetImage('assets/icons/ic_my_point.png'),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'my_points'.tr(),
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'TajawalBold'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<SpHelper>(context, listen: false).token == null
                      ? Provider.of<ApiAuthProvider>(context, listen: false)
                          .checkToken(context)
                      : RouterClass.routerClass.pushToScreenUsingWidget(
                          MyPackagesAndSubscriptionsScreen());
                },
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      children: [
                        Image(
                          height: 24.h,
                          width: 24.w,
                          image: const AssetImage('assets/icons/ic_medal2.png'),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'my_packages_and_subscriptions'.tr(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'TajawalBold'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<SpHelper>(context, listen: false).token == null
                      ? Provider.of<ApiAuthProvider>(context, listen: false)
                          .checkToken(context)
                      : RouterClass.routerClass
                          .pushToScreenUsingWidget(MyBillsScreen());
                },
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4.5,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      children: [
                        Image(
                          height: 24.h,
                          width: 24.w,
                          image: const AssetImage(
                              'assets/icons/ic_document_text.png'),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'my_bills'.tr(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'TajawalBold'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<SpHelper>(context, listen: false).token == null
                      ? Provider.of<ApiAuthProvider>(context, listen: false)
                          .checkToken(context)
                      : RouterClass.routerClass
                          .pushToScreenUsingWidget(const myContractScreen());
                },
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4.5,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      children: [
                        Image(
                          height: 24.h,
                          width: 24.w,
                          image:
                              const AssetImage('assets/icons/ic_document.png'),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'my_contract'.tr(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'TajawalBold'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              right: 12.w,
              left: 12.w,
              top: 16.h,
            ),
            child: Text(
              'general_settings'.tr(),
              style: const TextStyle(
                  color: Colors.black, fontFamily: 'TajawalRegular'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Provider.of<SpHelper>(context, listen: false).token == null
                  ? Provider.of<ApiAuthProvider>(context, listen: false)
                      .checkToken(context)
                  : RouterClass.routerClass
                      .pushToScreenUsingWidget(const NotificationsScreen());
            },
            child: Card(
              child: ListTile(
                title: Text(
                  'notifications'.tr(),
                  style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
                ),
                leading: Container(
                  padding: EdgeInsets.all(4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Image(
                    height: 24.h,
                    width: 24.w,
                    image:
                        const AssetImage('assets/icons/ic_notification2.png'),
                  ),
                ),
                trailing: Visibility(
                    visible: false,
                    child: Switch(value: true, onChanged: (value) {})),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (context.locale == Locale('en')) {
                context.setLocale(Locale('ar'));
                RestartWidget.restartApp(context);
              } else {
                context.setLocale(Locale('en'));
                RestartWidget.restartApp(context);
              }
            },
            child: Card(
              child: ListTile(
                title: Text(
                  'language'.tr(),
                  style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
                ),
                leading: Container(
                  padding: EdgeInsets.all(4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Image(
                    height: 24.h,
                    width: 24.w,
                    image: const AssetImage('assets/icons/ic_global.png'),
                  ),
                ),
                trailing: Text(
                  'english'.tr(),
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'TajawalRegular'),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              RouterClass.routerClass.pushToScreenUsingWidget(PoliciesScreen());
            },
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'policies'.tr(),
                      style:
                          TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
                    ),
                    leading: Container(
                      padding: EdgeInsets.all(4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Image(
                        height: 24.h,
                        width: 24.w,
                        image: const AssetImage('assets/icons/ic_tick2.png'),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              RouterClass.routerClass
                  .pushToScreenUsingWidget(const SupportAndHelpScreen());
            },
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'support_and_help'.tr(),
                      style:
                          TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
                    ),
                    leading: Container(
                      padding: EdgeInsets.all(4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Image(
                        height: 24.h,
                        width: 24.w,
                        image: const AssetImage(
                            'assets/icons/ic_tick_circle2.png'),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              RouterClass.routerClass
                  .pushToScreenUsingWidget(AboutBubleshBrandScreen());
            },
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'about_bublesh_brand'.tr(),
                      style:
                          TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
                    ),
                    leading: Container(
                      padding: EdgeInsets.all(4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Image(
                        height: 24.h,
                        width: 24.w,
                        image: const AssetImage(
                            'assets/icons/ic_info_circle2.png'),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Provider.of<ApiAuthProvider>(context, listen: false)
                  .logOut(context);
            },
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'logout'.tr(),
                      style:
                          TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
                    ),
                    leading: Container(
                      padding: EdgeInsets.all(4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Image(
                        height: 24.h,
                        width: 24.w,
                        image: const AssetImage('assets/icons/ic_logout2.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
