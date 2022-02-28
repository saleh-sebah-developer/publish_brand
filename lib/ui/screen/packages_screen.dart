import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_packages.dart';
import 'bouquet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class PackagesScreen extends StatefulWidget {
  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getPackages(context);
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<HomeProvider>(context).getPackages(context);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'packages'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: Provider.of<HomeProvider>(context).packages == null
          ? Center(
              child: Container(
                height: 50,
                width: 50,
                child: Lottie.asset('assets/animations/progress1.json'),
              ),
            )
          : Provider.of<HomeProvider>(context).packages.isEmpty
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
                          Provider.of<HomeProvider>(context).packages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: CustomPackages(
                            title: Provider.of<HomeProvider>(context)
                                .packages[index]
                                .title,
                            iconData: Provider.of<HomeProvider>(context)
                                .packages[index]
                                .image,
                            packagesProperties:
                                Provider.of<HomeProvider>(context)
                                    .packages[index]
                                    .packagesProperties
                                    .toList(),
                            price: Provider.of<HomeProvider>(context)
                                .packages[index]
                                .price
                                .toString(),
                            monthsCount: Provider.of<HomeProvider>(context)
                                .packages[index]
                                .monthsCount
                                .toString(),
                            package_id: Provider.of<HomeProvider>(context)
                                .packages[index]
                                .id
                                .toString(),
                            contract: Provider.of<HomeProvider>(context)
                                .packages[index]
                                .file,
                          ),
                        );
                      })),
    );
  }
}
