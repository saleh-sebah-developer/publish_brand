import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:publish_brand/data/sp_helper.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/submit_screen.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';

class ServiceDetailsScreen extends StatefulWidget {
  int service_id;

  ServiceDetailsScreen(this.service_id);

  GlobalKey<FormState> countServiceFormKey = GlobalKey<FormState>();

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false)
        .getServicesDetails(widget.service_id);
    Provider
        .of<HomeProvider>(context, listen: false)
        .countConService
        .text =
    '1';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, x) {
      return Scaffold(
        body: provider.selectedServices == null
            ? Center(
          child: SizedBox(
              height: 40.h,
              width: 40.w,
              child: Center(
                child: Lottie.asset('assets/animations/progress1.json'),
              )),
        )
            : LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
              BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 236.h,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child:
                          // provider.selectedServices.photos.length == 0
                          //     ? const Image(
                          //   image: AssetImage(
                          //       'assets/images/logo0.png'),
                          //   fit: BoxFit.cover,
                          // )
                          //    :
                  provider.selectedServices.image!=
                              null
                              ? CachedNetworkImage(
                            height: 159.h,
                            width: 167.w,
                            fit: BoxFit.cover,
                            imageUrl: provider
                                .selectedServices
                                .image,
                          )
                              : provider.selectedServices
                              .image.isEmpty
                              ? const Image(
                            image: AssetImage(
                                'assets/images/logo0.png'),
                            fit: BoxFit.cover,
                          )
                              : const Image(
                            image: AssetImage(
                                'assets/images/logo0.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 40.h, horizontal: 10.w),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  RouterClass.routerClass.popScreen();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                        Colors.white.withOpacity(0.5),
                                        borderRadius:
                                        BorderRadius.circular(5.r)),
                                    child: const Icon(
                                        Icons.arrow_back_ios_sharp,
                                        size: 30)),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 12.w, left: 12.w, top: 210.h),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(provider.selectedServices.title,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'TajawalBold',
                                      color: Colors.black)),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                          'price'.tr() +
                                              provider
                                                  .selectedServices.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily:
                                              'TajawalRegular',
                                              color: Colors.black)),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Container(
                                      child: Text(
                                          provider.selectedServices.type ==
                                              'fixed_price'
                                              ? provider.selectedServices.price
                                              .toString() +
                                              'sr'.tr()
                                              : provider.selectedServices
                                              .type ==
                                              'unfixed_price'
                                              ? 'the_price_is_negotiable'
                                              .tr()
                                              : provider.selectedServices
                                              .pointsCount
                                              .toString() +
                                              'point'.tr(),
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'TajawalBold',
                                              color: HexColor('#4091AF'))),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Text('estimated_time_to_implement'.tr(),
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: 'TajawalBold',
                                          color: Colors.black)),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text(
                                      provider.selectedServices
                                          .estimatedTime??'estimated' +
                                          'days'.tr(),
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: 'TajawalBold',
                                          color: HexColor('#4091AF'))),
                                ],
                              ),
                              Text(
                                  'note'.tr() ,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'TajawalRegular',
                                      color: Colors.black)),
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                margin: EdgeInsets.symmetric(vertical: 2.h),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('number'.tr(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'TajawalRegular',
                                            color: Colors.black)),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Container(
                                      height: 25,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: HexColor('#F5F5F5'),
                                          borderRadius:
                                          BorderRadius.circular(6)),
                                      child: Form(
                                        key: widget.countServiceFormKey,
                                        child: TextFormField(
                                          onChanged: (v) =>
                                              provider.totalPriceMethod(v),
                                          controller:
                                          provider.countConService,
                                          validator: (v) =>
                                              provider.validateCount(v),
                                          keyboardType:
                                          TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text('total_price'.tr(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'TajawalRegular',
                                            color: Colors.black)),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(provider.totalPrice.toString() ??
                                        provider.selectedServices.price
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'TajawalRegular',
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 16.h),
                          child: Text('service_details'.tr(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'TajawalBold',
                                  color: Colors.black)),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      child: Text(provider.selectedServices.details,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'TajawalRegular',
                              color: Colors.black)),
                      alignment: Alignment.centerRight,
                    ),
                    Spacer(),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                          right: 22.w,
                          left: 22.w,
                          bottom: 32.h,
                          top: 12.h),
                      margin: EdgeInsets.only(top: 20.h),
                      child: GestureDetector(
                        onTap: () {
                          if (Provider
                              .of<SpHelper>(context, listen: false)
                              .token == null) {
                            Provider.of<ApiAuthProvider>(context, listen: false)
                                .checkToken(context);
                          }
                          else if (widget.countServiceFormKey.currentState
                              .validate()) {
                            RouterClass.routerClass
                                .pushToScreenUsingWidget(SubmitService(
                              service: provider.selectedServices,
                            ));
                          }
                        },
                        child: CustomButtonY(
                          labelText: 'service_request'.tr(),
                          sizeButton: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
