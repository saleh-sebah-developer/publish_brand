
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publish_brand/providers/home_provider.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AllChatMessagesScreen extends StatelessWidget {

  TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, x) {
      return Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: ListTile(
                title: Text(
                  'title',
                  style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
                ),
                subtitle:  Text(
                  'subtitle',
                  style: TextStyle(fontSize: 16.sp, fontFamily: 'TajawalBold'),
                ),
                leading:  Icon( Icons.keyboard_arrow_right,
                  size: 40,
                ),
                trailing: Text(
                  'أنشئ اجتماع',
                  style: TextStyle(fontSize: 12.sp, fontFamily: 'TajawalBold'),
                ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: HexColor('#4091AF'),
                            shape: BoxShape.circle,
                           ),
                        child: Image(
                          height: 24.h,
                          width: 24.w,
                          color: Colors.white,
                          image: const AssetImage('assets/icons/ic_send.png'),
                        ),),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
