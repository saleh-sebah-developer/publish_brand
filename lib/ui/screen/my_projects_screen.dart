import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/data/sp_helper.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:publish_brand/providers/AppProvider.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/project_details.dart';
import 'package:publish_brand/ui/screen/service_details.dart';
import 'package:publish_brand/ui/widget/custom_service2.dart';
import 'package:lottie/lottie.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MyProjectsScreen extends StatefulWidget {
  const MyProjectsScreen({Key key}) : super(key: key);

  @override
  State<MyProjectsScreen> createState() => _MyProjectsScreenState();
}

class _MyProjectsScreenState extends State<MyProjectsScreen> {
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
    Provider.of<SpHelper>(context, listen: false).token != null
        ? Provider.of<HomeProvider>(context, listen: false)
            .getMyProjects(context)
        : () {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'my_projects'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: Provider.of<SpHelper>(context, listen: false).token == null
          ? Center(
              child: Lottie.asset('assets/animations/empty2.json'),
            )
          // Provider.of<ApiAuthProvider>(context, listen: false).checkToken(context)
          : Provider.of<HomeProvider>(context).myProjectsData == null
              ? Center(
                  child: Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  width: 40.w,
                  child: Lottie.asset('assets/animations/progress1.json'),
                ))
              : Provider.of<HomeProvider>(context).myProjectsData.isEmpty
                  ? Center(
                      child: Lottie.asset('assets/animations/empty2.json'),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          padding: EdgeInsets.all(2.h),
                          scrollDirection: Axis.vertical,
                          itemCount: Provider.of<HomeProvider>(context)
                              .myProjectsData
                              .length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Provider.of<HomeProvider>(context,
                                        listen: false)
                                    .project_id = Provider.of<HomeProvider>(
                                        context,
                                        listen: false)
                                    .myProjectsData[index]
                                    .id
                                    .toString();
                                RouterClass.routerClass.pushToScreenUsingWidget(
                                    ProjectDetailsScreen(
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .myProjectsData[index]
                                            .service,
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .myProjectsData[index]
                                            .id
                                            .toString()));
                              },
                              child: CustomService2(
                                title: Provider.of<HomeProvider>(context)
                                            .myProjectsData[index]
                                            .service !=
                                        null
                                    ? Provider.of<HomeProvider>(context)
                                        .myProjectsData[index]
                                        .service
                                        .title
                                    : 'null',
                                price: Provider.of<HomeProvider>(context)
                                            .myProjectsData[index]
                                            .service !=
                                        null
                                    ? Provider.of<HomeProvider>(context)
                                        .myProjectsData[index]
                                        .service
                                        .price
                                        .toString()
                                    : '0',
                                status: Provider.of<HomeProvider>(context)
                                    .myProjectsData[index]
                                    .status,
                                imageService: Provider.of<HomeProvider>(context)
                                            .myProjectsData[index]
                                            .service !=
                                        null
                                    ? Provider.of<HomeProvider>(context)
                                        .myProjectsData[index]
                                        .service
                                        .photos[0]
                                        .file
                                    : 'null',
                                type: Provider.of<HomeProvider>(context)
                                            .myProjectsData[index]
                                            .service !=
                                        null
                                    ? Provider.of<HomeProvider>(context)
                                            .myProjectsData[index]
                                            .service
                                            .type ??
                                        'unfixed_price'
                                    : 'null',
                                pointsCount: Provider.of<HomeProvider>(context)
                                            .myProjectsData[index]
                                            .service !=
                                        null
                                    ? Provider.of<HomeProvider>(context)
                                            .myProjectsData[index]
                                            .service
                                            .pointsCount
                                            .toString() ??
                                        'null'
                                    : 'null',
                              ),
                            );
                          })),
    );
  }
}
