import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class CustomService2 extends StatelessWidget {
  String imageService;
  String title;
  String price;
  String status;
  String type;
  String pointsCount;

  CustomService2(
      {Key key,
      this.imageService,
      this.title,
      this.price,
      this.status,
      this.type,
      this.pointsCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageService != 'null'
                ? CachedNetworkImage(
                    height: 95.h,
                    width: 94.w,
                    fit: BoxFit.cover,
                    imageUrl: imageService,
                  )
                : Image(
                    height: 95.h,
                    width: 94.w,
                    image: const AssetImage('assets/images/logo0.png'),
                  ),
            Container(
              width: MediaQuery.of(context).size.width/1.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    child: Text(
                      title ?? 'null',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'TajawalBold',
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    child: Text(
                      type == 'fixed_price'
                          ? price + 'sr'.tr()
                          : type == 'unfixed_price'
                              ? 'the_price_is_negotiable'.tr()
                              : type == 'points'
                                  ? pointsCount.toString() + 'point'.tr()
                                  : ' ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'TajawalBold',
                          color: HexColor('#4091AF')),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    child: Text(
                      status ?? 'new',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'TajawalBold',
                          color: HexColor('#F9B909')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
