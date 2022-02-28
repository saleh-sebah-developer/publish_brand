import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class CustomService extends StatelessWidget {
  String ImageService;
  String title;
  String titleSub;
  String type;
  String pointsCount;

  CustomService(
      {Key key,
      this.ImageService,
      this.title,
      this.titleSub,
      this.type,
      this.pointsCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      height: 235.h,
      width: 167.w,
      child: Column(
        children: [
          ImageService != 'null'
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    height: 159.h,
                    width: 167.w,
                    fit: BoxFit.cover,
                    imageUrl: ImageService,
                  ),
                )
              : Image(
                  height: 159.h,
                  width: 167.w,
                  image: const AssetImage('assets/images/logo0.png'),
                ),
          SizedBox(
            height: 4.h,
          ),
          SizedBox(
            width: 167.w,
            child: Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'TajawalBold',
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          SizedBox(
            width: 167.w,
            child: Text(
              type == 'fixed_price'
                  ? titleSub + 'sr'.tr()
                  : type == 'unfixed_price'
                      ? 'the_price_is_negotiable'.tr()
                      : pointsCount.toString() + 'point'.tr(),
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'TajawalBold',
                  color: HexColor('#4091AF')),
            ),
          ),
        ],
      ),
    );
  }
}
