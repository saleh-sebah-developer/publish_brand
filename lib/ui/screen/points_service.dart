import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/service_details_screen.dart';
import 'package:publish_brand/ui/widget/custom_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class PointsServicesScreen extends StatefulWidget {
  const PointsServicesScreen({Key key}) : super(key: key);

  @override
  State<PointsServicesScreen> createState() => _PointsServicesScreenState();
}

class _PointsServicesScreenState extends State<PointsServicesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false)
        .getServicesByPoints(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'points_services'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: TextFormField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  // ignore: missing_required_param
                  prefixIcon: const IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.0)),
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 12.h),
                  isDense: true,
                  hintStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
                  hintText: 'looking_for_any_service'.tr(),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              child: Text(
                'all_point_services'.tr(),
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'TajawalBold',
                    color: Colors.black),
                textAlign: TextAlign.end,
              ),
            ),
            Provider.of<HomeProvider>(context).servicesByPoint == null
                ? SizedBox(
                    height: 40.h,
                    width: 40.w,
                    child: Center(
                      child: Lottie.asset('assets/animations/progress1.json'),
                    ))
                : Provider.of<HomeProvider>(context).servicesByPoint.isEmpty
                    ? Center(
                        child: Lottie.asset('assets/animations/empty2.json'),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 235,
                                    mainAxisSpacing: 4),
                            itemCount: Provider.of<HomeProvider>(context)
                                .servicesByPoint
                                .length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  Provider.of<HomeProvider>(context,listen: false)
                                              .servicesByPoint[index]
                                              .points_count <=
                                          int.parse(Provider.of<HomeProvider>(
                                                  context,
                                                  listen: false)
                                              .numPoints)
                                      ? RouterClass.routerClass
                                          .pushToScreenUsingWidget(
                                              ServiceDetailsScreen(
                                                  Provider.of<HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .servicesByPoint[index]
                                                      .id))
                                      : ScaffoldMessenger.of(context)
                                          .showSnackBar( SnackBar(
                                          backgroundColor: Colors.red,
                                          content:
                                              Text('your_points_are_not_enough'.tr()),
                                          duration: Duration(seconds: 3),
                                        ));
                                },
                                child: CustomService(
                                  ImageService:
                                      Provider.of<HomeProvider>(context)
                                                  .servicesByPoint[index]
                                                  .photos ==
                                              null
                                          ? Provider.of<HomeProvider>(context)
                                                  .servicesByPoint[index]
                                                  .photos[0]
                                                  .file ??
                                              'null'
                                          : 'null',
                                  title: Provider.of<HomeProvider>(context)
                                          .servicesByPoint[index]
                                          .title ??
                                      'null',
                                  titleSub: Provider.of<HomeProvider>(context)
                                          .servicesByPoint[index]
                                          .price
                                          .toString() ??
                                      '0',
                                  type: Provider.of<HomeProvider>(context)
                                      .servicesByPoint[index]
                                      .type,
                                  pointsCount:
                                      Provider.of<HomeProvider>(context)
                                          .servicesByPoint[index]
                                          .points_count
                                          .toString(),
                                ),
                              );
                            }),
                      ),
          ],
        ),
      ),
    );
  }
}
