import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:publish_brand/data/sp_helper.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/login_screen.dart';
import 'package:publish_brand/ui/screen/policies.dart';
import 'package:publish_brand/ui/screen/profile_screen.dart';
import 'package:publish_brand/ui/screen/service_details_screen.dart';
import 'package:publish_brand/ui/screen/service_screen.dart';
import 'package:publish_brand/ui/screen/service_sections.dart';
import 'package:publish_brand/ui/screen/special_requests.dart';
import 'package:publish_brand/ui/screen/support_and_help.dart';
import 'package:publish_brand/ui/widget/custom_category_service.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/ui/widget/custom_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../providers/AppProvider.dart';
import 'about_bublesh_brand.dart';
import 'loyalty_points.dart';
import 'notifications.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  launchNormalUrl(String url) {
    launch(url);
  }

  openWhatsappChat(String mobileNumber) {
    launch(mobileNumber);
  }

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
    Provider.of<HomeProvider>(context, listen: false).settingsApiApp(context);
    Provider.of<SpHelper>(context, listen: false).getToken != null
        ? Provider.of<ApiAuthProvider>(context, listen: false).profile(context)
        : () {};
    Provider.of<SpHelper>(context, listen: false).getToken != null
        ? Provider.of<HomeProvider>(context, listen: false).getMyPoints(context)
        : () {};
  }

  TextEditingController searchHomeScreenCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
          actions: [
            GestureDetector(
              onTap: () {
                Provider.of<SpHelper>(context, listen: false).token == null
                    ? Provider.of<ApiAuthProvider>(context, listen: false)
                        .checkToken(context)
                    : RouterClass.routerClass
                        .pushToScreenUsingWidget(const NotificationsScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5.r)),
                child: Image(
                  height: 30.h,
                  width: 30.w,
                  image: const AssetImage('assets/icons/ic_noification.png'),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
          leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.openDrawer();
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5.r)),
                margin: EdgeInsets.only(right: 8),
                child: Visibility(
                  visible: true,
                  child: Image(
                    height: 30.h,
                    width: 30.w,
                    image: const AssetImage('assets/icons/ic_menu.png'),
                  ),
                )),
          ),
          leadingWidth: 40,
        ),
      ),
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 150.h,
              color: HexColor('#FAFAFA'),
              padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        padding: EdgeInsets.all(2.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 12.h),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        )),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14.w),
                                child: Text(
                                  Provider.of<SpHelper>(context, listen: false)
                                              .token ==
                                          null
                                      ? 'new_user'.tr()
                                      : Provider.of<ApiAuthProvider>(context)
                                              .currentUser
                                              ?.name ??
                                          '',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'TajawalBold'),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                Provider.of<SpHelper>(context, listen: false)
                                            .token ==
                                        null
                                    ? 'loyalty_points'.tr() +
                                        ' 0' +
                                        'point'.tr()
                                    : 'loyalty_points'.tr() +
                                        ' ' +
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .numPoints
                                            .toString() +
                                        'point'.tr(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'TajawalRegular'),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Provider.of<SpHelper>(context, listen: false)
                                          .token ==
                                      null
                                  ? Provider.of<ApiAuthProvider>(context,
                                          listen: false)
                                      .checkToken(context)
                                  : RouterClass.routerClass
                                      .pushToScreenUsingWidget(ProfileScreen());
                            },
                            child: Container(
                                padding: EdgeInsets.all(6.h),
                                margin: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Image(
                                  height: 24.h,
                                  width: 24.w,
                                  image: const AssetImage(
                                      'assets/icons/ic_setting.png'),
                                )),
                          ),
                        ],
                      )),
                ],
              ),
            ),

            /*
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              title: Text(
                'home'.tr(),
                style: TextStyle(
                    color: HexColor('#666666'),
                    fontSize: 14.sp,
                    fontFamily: 'TajawalRegular'),
              ),
              leading: Image(
                height: 24.h,
                width: 24.w,
                image: AssetImage('assets/icons/ic_home.png'),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              title: Text(
                'my_projects'.tr(),
                style: TextStyle(
                    color: HexColor('#666666'),
                    fontSize: 14.sp,
                    fontFamily: 'TajawalRegular'),
              ),
              leading: Image(
                height: 24.h,
                width: 24.w,
                image: AssetImage('assets/icons/ic_send.png'),
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                'packages_and_subscriptions'.tr(),
                style: TextStyle(
                    color: HexColor('#666666'),
                    fontSize: 14.sp,
                    fontFamily: 'TajawalRegular'),
              ),
              leading:Image(
                height: 24.h,
                width: 24.w,
                image: AssetImage('assets/icons/ic_medal.png'),
              ),
            ),
            */
            ListTile(
              onTap: () {
                RouterClass.routerClass
                    .pushToScreenUsingWidget(ServiceSections());
              },
              title: Text(
                'service_sections'.tr(),
                style: TextStyle(
                    color: HexColor('#666666'),
                    fontSize: 14.sp,
                    fontFamily: 'TajawalRegular'),
              ),
              leading: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage('assets/icons/ic_3dcube.png'),
              ),
            ),
            ListTile(
              onTap: () {
                RouterClass.routerClass
                    .pushToScreenUsingWidget(SpecialRequestsScreen());
              },
              title: Text(
                'submit_special_requests'.tr(),
                style: TextStyle(
                    color: HexColor('#666666'),
                    fontSize: 14.sp,
                    fontFamily: 'TajawalRegular'),
              ),
              leading: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage('assets/icons/ic_clipboard_text.png'),
              ),
            ),
            ListTile(
              onTap: () {
                Provider.of<SpHelper>(context, listen: false).token == null
                    ? Provider.of<ApiAuthProvider>(context, listen: false)
                        .checkToken(context)
                    : RouterClass.routerClass
                        .pushToScreenUsingWidget(LoyaltyPointsScreen());
              },
              title: Text(
                'loyalty_points'.tr(),
                style: TextStyle(
                    color: HexColor('#666666'),
                    fontSize: 14.sp,
                    fontFamily: 'TajawalRegular'),
              ),
              leading: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage('assets/icons/ic_star.png'),
              ),
            ),
            ListTile(
              onTap: () {
                RouterClass.routerClass
                    .pushToScreenUsingWidget(AboutBubleshBrandScreen());
              },
              title: Text(
                'about_bublesh_brand'.tr(),
                style: TextStyle(
                    color: HexColor('#666666'),
                    fontSize: 14.sp,
                    fontFamily: 'TajawalRegular'),
              ),
              leading: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage('assets/icons/ic_info_circle.png'),
              ),
            ),
            ListTile(
              onTap: () {
                RouterClass.routerClass
                    .pushToScreenUsingWidget(PoliciesScreen());
              },
              title: Text(
                'policies'.tr(),
                style: TextStyle(
                    color: HexColor('#666666'),
                    fontSize: 14.sp,
                    fontFamily: 'TajawalRegular'),
              ),
              leading: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage('assets/icons/ic_clipboard_tick.png'),
              ),
            ),
            ListTile(
              onTap: () {
                RouterClass.routerClass
                    .pushToScreenUsingWidget(SupportAndHelpScreen());
              },
              title: Text(
                'support_and_help'.tr(),
                style: TextStyle(
                    color: HexColor('#666666'),
                    fontSize: 14.sp,
                    fontFamily: 'TajawalRegular'),
              ),
              leading: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage('assets/icons/ic_tick_circle.png'),
              ),
            ),
            ListTile(
              onTap: () {
                Provider.of<ApiAuthProvider>(context, listen: false)
                    .logOut(context);
              },
              title: Text(
                'logout'.tr(),
                style: TextStyle(
                    color: HexColor('#666666'),
                    fontSize: 14.sp,
                    fontFamily: 'TajawalRegular'),
              ),
              leading: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage('assets/icons/ic_logout.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 22.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      launchNormalUrl(
                          Provider.of<HomeProvider>(context, listen: false)
                              .urlApp);
                    },
                    child: Text(
                      Provider.of<HomeProvider>(context, listen: false).urlApp,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'TajawalBold',
                          color: HexColor('#4091AF')),
                    ),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  Text(
                    'our_social_media_account'.tr(),
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'TajawalBold',
                        color: HexColor('#666666')),
                  ),
                  SizedBox(
                    height: 6.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchNormalUrl(
                              Provider.of<HomeProvider>(context, listen: false)
                                  .urlFacebookApp);
                        },
                        child: Image(
                          height: 32.h,
                          width: 32.w,
                          image:
                              const AssetImage('assets/icons/ic_facebook.png'),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          launchNormalUrl(
                              Provider.of<HomeProvider>(context, listen: false)
                                  .urlTwitterApp);
                        },
                        child: Image(
                          height: 32.h,
                          width: 32.w,
                          image:
                              const AssetImage('assets/icons/ic_twitter.png'),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          openWhatsappChat(
                              Provider.of<HomeProvider>(context, listen: false)
                                  .urlWhatsappApp);
                        },
                        child: Image(
                          height: 32.h,
                          width: 32.w,
                          image:
                              const AssetImage('assets/icons/ic_whatsapp.png'),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          launchNormalUrl(
                              Provider.of<HomeProvider>(context, listen: false)
                                  .urlInstagramApp);
                        },
                        child: Image(
                          height: 32.h,
                          width: 32.w,
                          image: const AssetImage('assets/icons/ic_insta.png'),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          launchNormalUrl(
                              Provider.of<HomeProvider>(context, listen: false)
                                  .urlYoutubeApp);
                        },
                        child: Image(
                          height: 32.h,
                          width: 32.w,
                          image:
                              const AssetImage('assets/icons/ic_youtube.png'),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Consumer<HomeProvider>(builder: (context, provider, x) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  provider.listAds == null
                      ? Container(
                          height: 236.h,
                          child: Center(
                            child: SizedBox(
                                height: 40.h,
                                width: 40.w,
                                child: Center(
                                  child: Lottie.asset(
                                      'assets/animations/progress1.json'),
                                )),
                          ),
                        )
                      : provider.listAds.isEmpty
                          ? Center(
                              child:
                                  Lottie.asset('assets/animations/empty2.json'),
                            )
                          : CarouselSlider(
                              options: CarouselOptions(
                                height: 256.h,
                                autoPlay: true,
                              ),
                              items: provider.listAds.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        padding: EdgeInsets.symmetric(horizontal:1.w),
                                        decoration: const BoxDecoration(
                                            color: Colors.white10),
                                        child: CachedNetworkImage(
                                          height: 236.h,
                                          width: 375.w,
                                          imageUrl: i.image,
                                        ));
                                  },
                                );
                              }).toList(),
                            ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 40.h, bottom: 42, right: 12.w, left: 8.w),
                    child: Row(
                      children: [
                        Visibility(
                          visible: false,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Visibility(
                                visible: true,
                                child: Image(
                                  height: 30.h,
                                  width: 30.w,
                                  image: const AssetImage(
                                      'assets/icons/ic_menu.png'),
                                ),
                              )),
                        ),
                        const Spacer(),
                        Visibility(
                          visible: false,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Visibility(
                              visible: true,
                              child: Image(
                                height: 30.h,
                                width: 30.w,
                                image: const AssetImage(
                                    'assets/icons/ic_noification.png'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(right: 8.w, left: 8.w, top: 210.h),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        provider.searchHomeScreen(value);
                      },
                      controller: searchHomeScreenCon,
                      textAlign: TextAlign.start,
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
                            searchHomeScreenCon.clear();
                            provider.searchHomeScreen('');
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0.0)),
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        isDense: true,
                        hintStyle:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        hintText: 'look_for'.tr(),
                      ),
                    ),
                  ),
                ],
              ),
              // ElevatedButton(onPressed: (){
              //   log( Provider.of<SpHelper>(context, listen: false).token);
              // }, child: Text('dddddddd')),
              Container(
                margin: EdgeInsets.only(right: 12.w, left: 12.w, top: 12.h),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      margin:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      child: Text(
                        'service_sections'.tr(),
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'TajawalBold',
                            color: Colors.black),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        RouterClass.routerClass
                            .pushToScreenUsingWidget(ServiceSections());
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Text(
                          'see_all'.tr(),
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'TajawalBold',
                              color: Colors.blueAccent),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              provider.categories == null
                  ? Container(
                height: 180.h,
                child: Center(
                  child: SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: Center(
                        child: Lottie.asset(
                            'assets/animations/progress1.json'),
                      )),
                ),
              )
                  : provider.categories.isEmpty
                  ? Center(
                child:
                Lottie.asset('assets/animations/empty2.json'),
              )
                  :
              Container(
                height: 180.h,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 100,
                            mainAxisSpacing: 4),
                    itemCount: searchHomeScreenCon.text.isNotEmpty
                        ? provider.searchCategories.length
                        : provider.categories.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          RouterClass.routerClass.pushToScreenUsingWidget(
                              ServiceScreen(searchHomeScreenCon.text.isNotEmpty
                                  ? provider.searchCategories[index].id
                                  : provider.categories[index].id));
                        },
                        child: CustomCategoryService(
                          label: searchHomeScreenCon.text.isNotEmpty
                              ? provider.searchCategories[index].name
                              : provider.categories[index].name,
                          iconData: searchHomeScreenCon.text.isNotEmpty
                              ? provider.searchCategories[index].image
                              : provider.categories[index].image,
                        ),
                      );
                    }),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: Text(
                  'newly_added_services'.tr(),
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'TajawalBold',
                      color: Colors.black),
                  textAlign: TextAlign.end,
                ),
              ),
              provider.services == null
                  ? Container(
                height: MediaQuery.of(context).size.height / 3.5,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: Center(
                        child: Lottie.asset(
                            'assets/animations/progress1.json'),
                      )),
                ),
              )
                  : provider.services.isEmpty
                  ? Center(
                child:
                Lottie.asset('assets/animations/empty2.json'),
              )
                  :
              SizedBox(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      padding: EdgeInsets.all(2.h),
                      scrollDirection: Axis.horizontal,
                      itemCount: searchHomeScreenCon.text.isNotEmpty
                          ? provider.searchServices.length
                          : provider.services.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            RouterClass.routerClass.pushToScreenUsingWidget(
                                ServiceDetailsScreen(
                                    searchHomeScreenCon.text.isNotEmpty
                                        ? provider.searchServices[index].id
                                        : provider.services[index].id));
                          },
                          child: CustomService(
                            ImageService: searchHomeScreenCon.text.isNotEmpty
                                ? provider.searchServices[index].photos[0].file?? 'null'
                                :
                            provider.services[index].photos.length!=0?
                            provider.services[index].photos[0].file?? 'null':'null',
                            title: searchHomeScreenCon.text.isNotEmpty
                                ? provider.searchServices[index].title
                                : provider.services[index].title,
                            titleSub: searchHomeScreenCon.text.isNotEmpty
                                ? provider.searchServices[index].price
                                    .toString()
                                : provider.services[index].price.toString(),
                            type: searchHomeScreenCon.text.isNotEmpty
                                ? provider.searchServices[index].type.toString()
                                : provider.services[index].type.toString(),
                            pointsCount: searchHomeScreenCon.text.isNotEmpty
                                ? provider.searchServices[index].pointsCount
                                    .toString()
                                : provider.services[index].pointsCount
                                    .toString(),
                          ),
                        );
                      })),
            ],
          ),
        );
      }),
    );
  }
}
