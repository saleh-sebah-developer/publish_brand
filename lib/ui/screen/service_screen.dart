import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/service_details.dart';
import 'package:publish_brand/ui/screen/service_details_screen.dart';
import 'package:publish_brand/ui/widget/custom_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class ServiceScreen extends StatefulWidget {
  int category_id;

  ServiceScreen(this.category_id);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false)
        .getServicesByCategory(widget.category_id);
  }

  TextEditingController searchServiceScreenCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<HomeProvider>(context, listen: false)
            .clearServicesByCategory();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white.withOpacity(0.5),
          middle: Text(
            'department'.tr() +
                Provider.of<HomeProvider>(context, listen: false)
                    .nameSelectedCategory,
            style: TextStyle(
                color: HexColor("#4091AF"),
                fontSize: 16.sp,
                fontFamily: 'TajawalBold'),
          ),
        ),
        body: ListView(
            children: [
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: TextFormField(
              textAlign: TextAlign.start,
              onChanged: (value) {
                Provider.of<HomeProvider>(context, listen: false)
                    .searchServiceScreen(value);
              },
              controller: searchServiceScreenCon,
              decoration: InputDecoration(
                // ignore: missing_required_param
                prefixIcon: const IconButton(
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.black,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchServiceScreenCon.clear();
                    Provider.of<HomeProvider>(context, listen: false)
                        .searchServiceScreen('');
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
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
                hintText: 'look_for2'.tr(),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            child: Text(
              'all_services'.tr() +
                  Provider.of<HomeProvider>(context, listen: false)
                      .nameSelectedCategory,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'TajawalBold',
                  color: Colors.black),
              textAlign: TextAlign.end,
            ),
          ),
          Provider.of<HomeProvider>(context).servicesByCategory == null
              ? SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: Center(
                    child: Lottie.asset('assets/animations/progress1.json'),
                  ))
              : Provider.of<HomeProvider>(context).servicesByCategory.isEmpty
                  ? Center(
                      child: Lottie.asset('assets/animations/empty2.json'),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(bottom: 200),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 235,
                                  mainAxisSpacing: 4),
                          itemCount: searchServiceScreenCon.text.isNotEmpty
                              ? Provider.of<HomeProvider>(context)
                                  .searchServicesByCategory
                                  .length
                              : Provider.of<HomeProvider>(context)
                                  .servicesByCategory
                                  .length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                RouterClass.routerClass
                                    .pushToScreenUsingWidget(
                                        ServiceDetailsScreen(
                                            searchServiceScreenCon
                                                    .text.isNotEmpty
                                                ? Provider.of<HomeProvider>(
                                                        context,
                                                        listen: false)
                                                    .searchServicesByCategory[
                                                        index]
                                                    .id
                                                : Provider.of<HomeProvider>(
                                                        context,
                                                        listen: false)
                                                    .services[index]
                                                    .id));
                              },
                              child: CustomService(
                                ImageService:
                                    searchServiceScreenCon.text.isNotEmpty
                                        ? Provider.of<HomeProvider>(context)
                                            .searchServicesByCategory[index]
                                            .photos[0]
                                            .file
                                        : Provider.of<HomeProvider>(context)
                                            .servicesByCategory[index]
                                            .photos[0]
                                            .file,
                                title: searchServiceScreenCon.text.isNotEmpty
                                    ? Provider.of<HomeProvider>(context)
                                        .searchServicesByCategory[index]
                                        .title
                                    : Provider.of<HomeProvider>(context)
                                        .servicesByCategory[index]
                                        .title,
                                titleSub:
                                    searchServiceScreenCon.text.isNotEmpty
                                        ? Provider.of<HomeProvider>(context)
                                            .searchServicesByCategory[index]
                                            .price
                                            .toString()
                                        : Provider.of<HomeProvider>(context)
                                            .servicesByCategory[index]
                                            .price
                                            .toString(),
                                type: searchServiceScreenCon.text.isNotEmpty
                                    ? Provider.of<HomeProvider>(context)
                                        .searchServicesByCategory[index]
                                        .type
                                        .toString()
                                    : Provider.of<HomeProvider>(context)
                                        .servicesByCategory[index]
                                        .type
                                        .toString(),
                                pointsCount:
                                    searchServiceScreenCon.text.isNotEmpty
                                        ? Provider.of<HomeProvider>(context)
                                            .searchServicesByCategory[index]
                                            .pointsCount
                                            .toString()
                                        : Provider.of<HomeProvider>(context)
                                            .servicesByCategory[index]
                                            .pointsCount
                                            .toString(),
                              ),
                            );
                          }),
                    ),
        ]),
      ),
    );
  }
}
