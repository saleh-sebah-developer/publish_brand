import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publish_brand/data/sp_helper.dart';
import 'package:publish_brand/providers/api_auth_provider.dart';
import 'package:publish_brand/ui/screen/home_screen.dart';
import 'package:publish_brand/ui/screen/packages_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'more_screen.dart';
import 'my_projects_screen.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage('assets/icons/ic_home.png'),
              ),
              label: "home".tr()),
          BottomNavigationBarItem(
              icon: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage('assets/icons/ic_send.png'),
              ),
              label: "my_projects".tr()),
          BottomNavigationBarItem(
              icon: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage('assets/icons/ic_medal.png'),
              ),
              label: "packages".tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.more_horiz), label: "more".tr()),
        ],
      ),
      body: index == 0
          ? HomeScreen()
          : index == 1
              ?   MyProjectsScreen()
              : index == 2
                  ? PackagesScreen()
                  : MoreScreen(),
    );
  }
}
