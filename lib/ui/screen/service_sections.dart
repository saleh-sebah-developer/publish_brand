import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/screen/service_screen.dart';
import 'package:publish_brand/ui/widget/custom_category_service2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ServiceSections extends StatelessWidget {
  const ServiceSections({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'service_sections'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 90,
                mainAxisSpacing: 4
            ),
            itemCount: Provider.of<HomeProvider>(context).categories.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  RouterClass.routerClass.pushToScreenUsingWidget(ServiceScreen(
                      Provider.of<HomeProvider>(context, listen: false)
                          .categories[index]
                          .id));
                },
                child: CustomCategoryService2(
                  label:
                      Provider.of<HomeProvider>(context).categories[index].name,
                  labelSub: 'service '.tr() +
                      Provider.of<HomeProvider>(context)
                          .categories[index]
                          .servicesCount
                          .toString(),
                  iconData: Provider.of<HomeProvider>(context)
                      .categories[index]
                      .image,
                ),
              );
            }),
      ),
    );
  }
}
