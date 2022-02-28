import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/ui/widget/custom_button_n.dart';

import 'package:provider/provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:publish_brand/ui/widget/custom_packages.dart';
import 'package:publish_brand/ui/widget/custom_packages2.dart';

class MyPackagesAndSubscriptionsScreen extends StatefulWidget {
  const MyPackagesAndSubscriptionsScreen({Key key}) : super(key: key);

  @override
  State<MyPackagesAndSubscriptionsScreen> createState() =>
      _MyPackagesAndSubscriptionsScreenState();
}

class _MyPackagesAndSubscriptionsScreenState
    extends State<MyPackagesAndSubscriptionsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context,listen: false).getMyPackages(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'my_packages_and_subscriptions'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: Provider.of<HomeProvider>(context).listPackage==null
          ? Center(
              child: Container(
                height: 50,
                width: 50,
                child: Lottie.asset('assets/animations/progress1.json'),
              ),
            )
          : Provider.of<HomeProvider>(context).listPackage.isEmpty
              ? Center(
                  child: Container(
                    child: Lottie.asset('assets/animations/empty2.json'),
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      padding: EdgeInsets.all(2.h),
                      scrollDirection: Axis.vertical,
                      itemCount:
                          Provider.of<HomeProvider>(context).listPackage.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: CustomPackages2(
                            title: Provider.of<HomeProvider>(context)
                                .listPackage[index]
                                .package
                                .title,
                            iconData: Provider.of<HomeProvider>(context)
                                .listPackage[index]
                                .package
                                .image,
                            packagesProperties:
                                Provider.of<HomeProvider>(context)
                                    .listPackage[index]
                                    .package
                                    .packagesProperties
                                    .toList(),
                            price: Provider.of<HomeProvider>(context)
                                .listPackage[index]
                                .package
                                .price
                                .toString(),
                            package_id: Provider.of<HomeProvider>(context)
                                .listPackage[index]
                                .package
                                .id
                                .toString(),
                            expired_date: Provider.of<HomeProvider>(context)
                                .listPackage[index]
                                .expiredDate
                                .toString(),
                          ),
                        );
                      })),
    );
  }
}
