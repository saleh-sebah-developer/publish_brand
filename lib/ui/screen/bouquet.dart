import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/models/get_packages_response.dart';
import 'package:publish_brand/providers/AppProvider.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/payment_confirmation1.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:publish_brand/ui/widget/custom_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:isolate';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../providers/SalehProvider.dart';

// ignore: must_be_immutable
class BouquetScreen extends StatefulWidget {
  String title;
  String iconData;
  List<PackagesProperties> packagesProperties;
  String price;
  String monthsCount;
  String package_id;
  String contract;

  BouquetScreen(this.title, this.iconData, this.packagesProperties, this.price,
      this.monthsCount, this.package_id, this.contract);

  @override
  State<BouquetScreen> createState() => _BouquetScreenState();
}

class _BouquetScreenState extends State<BouquetScreen> {
  TextEditingController loginPhoneCon = TextEditingController();
  Function function;
  GlobalKey<FormState> bouquetFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).packageId =
        widget.package_id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          widget.title + ' bouquet'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Container(
          child: Consumer3<HomeProvider, ApiAuthProvider, AppProvider>(
              builder: (context, providerHome, providerAuth, providerApp, x) {
            return Form(
              key: bouquetFormKey,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ExpansionTile(
                                title: Text(
                                  widget.title,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: 'TajawalBold'),
                                ),
                                leading: Container(
                                    padding: EdgeInsets.all(4.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: HexColor('#145366'),
                                    ),
                                    child: widget.iconData != null
                                        ? CachedNetworkImage(
                                            height: 24.h,
                                            width: 24.w,
                                            imageUrl: widget.iconData,
                                          )
                                        : Image(
                                            height: 24.h,
                                            width: 24.w,
                                            image: const AssetImage(
                                                'assets/icons/ic_brush.png'),
                                          )),
                                trailing: const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 40,
                                ),
                                children: [
                                  for (int i = 0;
                                      i < widget.packagesProperties.length;
                                      i++)
                                    ListTile(
                                      // ignore: prefer_const_constructors
                                      title: Text(
                                        widget.packagesProperties[i].title,
                                      ),
                                      leading: Image(
                                        height: 24.h,
                                        width: 24.w,
                                        image: const AssetImage(
                                            'assets/icons/ic_spark.png'),
                                      ),
                                      minLeadingWidth: 10,
                                    ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 2.h),
                                    child: Text(
                                      widget.price +
                                          ' / ' +
                                          widget.monthsCount +
                                          'month'.tr(),
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontFamily: 'TajawalBold'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 12.w, left: 12.w, top: 12.h),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'please_download_fill_out_and_reattach_the_contract'
                                .tr(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'TajawalRegular',
                                fontSize: 16.sp),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                         //   providerApp.download2(widget.contract);
                           // Provider.of<SalehProvider>(context,listen: false).download2('https://publishbrand.homeshopuae.com/public/uploads/packages/attach1645864112_43719file.docx');
                            Provider.of<SalehProvider>(context,listen: false).download2(widget.contract);
/*
                            final status = await Permission.storage.request();
                            if (status.isGranted) {
                              final externalDir =
                                  await getExternalStorageDirectory();
                              final id = await FlutterDownloader.enqueue(
                                  url: widget.contract,
                                  savedDir: externalDir.path,
                                  fileName: 'download invoice File',
                                  showNotification: true,
                                  openFileFromNotification: true);
                            } else {
                              print('permission denied');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('permission denied'),
                                duration: Duration(seconds: 3),
                              ));
                            }
                            */
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 12.w, left: 12.w, bottom: 12.h),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'to_download_the_contract_click_here'.tr(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: HexColor("#4091AF"),
                                  fontFamily: 'TajawalRegular',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16.sp),
                            ),
                          ),
                        ),
                        CustomTextField(
                          controller: providerHome.detailsConBouquet,
                          textInputType: TextInputType.text,
                          labelText: 'details_of_the_required_package'.tr(),
                          labelTextHint:
                              'hint_details_of_the_required_package'.tr(),
                          validationFun: providerAuth.validateNull,
                        ),
                        GestureDetector(
                          onTap: () async {
                            providerHome.uploadFile();
                            print('upload file');
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 14.h,
                                bottom: 20.h),
                            margin: EdgeInsets.only(
                                left: 8.w, right: 8.w, bottom: 4.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'raise_the_contract'.tr(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'TajawalRegular',
                                      fontSize: 16.sp),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                ListTile(
                                  title: Text(
                                    'hint_raise_the_contract'.tr(),
                                    style: TextStyle(
                                        color: HexColor('#9DA1A2'),
                                        fontFamily: 'TajawalRegular',
                                        fontSize: 16.sp),
                                  ),
                                  leading:
                                      const Icon(Icons.cloud_upload_outlined),
                                )
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            RouterClass.routerClass.pushToScreenUsingWidget(
                                PaymentConfirmation1Screen(
                                    widget.title,
                                    widget.iconData,
                                    widget.packagesProperties,
                                    widget.price,
                                    widget.monthsCount,
                                    widget.package_id));
                          },
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 22.w, vertical: 34.h),
                            child: CustomButtonY(
                              labelText: 'continue_to_subscribe'.tr(),
                              sizeButton: 1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
