import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:publish_brand/ui/widget/mycontract.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyBillsScreen extends StatefulWidget {
  const MyBillsScreen({Key key}) : super(key: key);

  @override
  State<MyBillsScreen> createState() => _MyBillsScreenState();
}

class _MyBillsScreenState extends State<MyBillsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getMyInvoices(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white.withOpacity(0.5),
        middle: Text(
          'my_bills'.tr(),
          style: TextStyle(
              color: HexColor("#4091AF"),
              fontSize: 16.sp,
              fontFamily: 'TajawalBold'),
        ),
      ),
      body: Provider.of<HomeProvider>(context).invoices == null
          ? Center(
              child: Container(
                height: 50,
                width: 50,
                child: Lottie.asset('assets/animations/progress1.json'),
              ),
            )
          : Provider.of<HomeProvider>(context).invoices.isEmpty
              ? Center(
                  child: Container(
                    child: Lottie.asset('assets/animations/empty2.json'),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(2.h),
                  scrollDirection: Axis.vertical,
                  itemCount: Provider.of<HomeProvider>(context).invoices.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        final status = await Permission.storage.request();
                        if (status.isGranted) {
                          final externalDir =
                          await getExternalStorageDirectory();
                          final id= await FlutterDownloader.enqueue(
                              url: Provider.of<HomeProvider>(context,listen: false)
                                  .invoices[index]
                                  .file,
                              savedDir: externalDir.path,
                              fileName: 'download invoice File',
                              showNotification: true,
                              openFileFromNotification: true);
                        } else {
                          print('permission denied');
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('permission denied'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: CustomMyContract(
                        label: 'invoice_date'.tr() +
                            Provider.of<HomeProvider>(context)
                                .invoices[index]
                                .createdAt
                                .substring(0, 9)
                                .toString(),
                      ),
                    );
                  }),
    );
  }
}
