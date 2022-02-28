import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/submit_screen.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ServiceDetailsScreen2 extends StatefulWidget {
  int service_id;
  ServiceDetailsScreen2(this.service_id);

  @override
  State<ServiceDetailsScreen2> createState() => _ServiceDetailsScreen2State();
}

class _ServiceDetailsScreen2State extends State<ServiceDetailsScreen2> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context,listen: false).getServicesDetails(widget.service_id);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 236.h,
                  width: MediaQuery.of(context).size.width,
                  child:
                  Provider.of<HomeProvider>(context,listen: false).selectedServices.photos[0].file!=null?
                  CachedNetworkImage(
                    height: 159.h,
                    width: 167.w,
                    fit: BoxFit.cover,
                    imageUrl:  Provider.of<HomeProvider>(context,listen: false).selectedServices.photos[0].file,
                  ):
                  Provider.of<HomeProvider>(context,listen: false).selectedServices.photos[0].file.isEmpty?
                  const Image(
                    image: AssetImage('assets/images/service_details.png'),
                    fit: BoxFit.cover,
                  ):const Image(
                    image: AssetImage('assets/images/service_details.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 40.h, horizontal: 10.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          RouterClass.routerClass.popScreen();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5.r)),
                            child: const Icon(Icons.arrow_back_ios_sharp,
                                size: 30)),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 12.w, left: 12.w, top: 210.h),
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(Provider.of<HomeProvider>(context).selectedServices.title,
                          style:  TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'TajawalBold',
                              color: Colors.black)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('price'.tr()+Provider.of<HomeProvider>(context).selectedServices.title,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'TajawalRegular',
                                  color: Colors.black)),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(Provider.of<HomeProvider>(context).selectedServices.price.toString()+'sr'.tr(),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'TajawalBold',
                                  color: HexColor('#4091AF'))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('estimated_time_to_implement'.tr(),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'TajawalBold',
                                  color: Colors.black)),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(Provider.of<HomeProvider>(context).selectedServices.estimatedTime+'days'.tr(),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'TajawalBold',
                                  color: HexColor('#4091AF'))),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Text('service_details'.tr(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'TajawalBold',
                      color: Colors.black)),
              alignment: Alignment.centerRight,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Text(  Provider.of<HomeProvider>(context).selectedServices.details,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'TajawalRegular',
                      color: Colors.black)),
              alignment: Alignment.centerRight,
            ),
          ],
        ),
      ),
    );
  }
}
