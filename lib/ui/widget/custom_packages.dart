import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:publish_brand/data/sp_helper.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/models/get_packages_response.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/bouquet.dart';
import 'package:publish_brand/ui/screen/special_requests.dart';
import 'custom_button_y.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomPackages extends StatelessWidget {
  String title;
  String iconData;
  List<PackagesProperties> packagesProperties;
  String price;
  String monthsCount;
  String package_id;
  String contract;

  CustomPackages(
      {this.title, this.iconData, this.packagesProperties, this.price,this.monthsCount, this.package_id,this.contract});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ExpansionTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
            ),
            leading: Container(
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: HexColor('#145366'),
                ),
                child: iconData != null
                    ? CachedNetworkImage(
                  height: 24.h,
                  width: 24.w,
                  imageUrl: iconData,
                )
                    : Image(
                  height: 24.h,
                  width: 24.w,
                  image: const AssetImage('assets/icons/ic_brush.png'),
                )),
            trailing: const Icon(
              Icons.keyboard_arrow_down,
              size: 40,
            ),
            children: [
              for (int i = 0; i < packagesProperties.length; i++)
                ListTile(
                  // ignore: prefer_const_constructors
                  title: Text(
                    packagesProperties[i].title,
                  ),
                  leading: Image(
                    height: 24.h,
                    width: 24.w,
                    image: const AssetImage('assets/icons/ic_spark.png'),
                  ),
                  minLeadingWidth: 10,
                ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                child: Text(
                  price +' / '+ monthsCount+'month'.tr(),
                  style: TextStyle(fontSize: 20.sp, fontFamily: 'TajawalBold'),
                ),
              ),
              ListTile(
                onTap: (){
                  RouterClass.routerClass.pushToScreenUsingWidget(SpecialRequestsScreen());
                },
                // ignore: prefer_const_constructors
                title: Text(
                  'request_a_special_request'.tr(),
                ),
                leading: Icon(Icons.add),
                minLeadingWidth: 10,
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<SpHelper>(context, listen: false).token==null?
                  Provider.of<ApiAuthProvider>(context, listen: false).checkToken(context)
                  :RouterClass.routerClass
                      .pushToScreenUsingWidget(BouquetScreen(title,iconData,packagesProperties,price,monthsCount,package_id,contract));
                },
                child: Container(
                  margin:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: CustomButtonY(
                    labelText: 'subscribe'.tr(),
                    sizeButton: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
