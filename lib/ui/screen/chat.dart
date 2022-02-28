import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publish_brand/ui/widget/custom_button_n.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       margin: EdgeInsets.only(top: 40),
       child: Column(
         children: [
             ListTile(
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
           Spacer(),
           Container(
             color: Colors.white,
             padding:
             EdgeInsets.symmetric(horizontal: 22.w, vertical: 34.h),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 GestureDetector(
                   onTap: () {
                   },
                   child: CustomButtonN(
                     labelText: 'login'.tr(),
                     sizeButton: 2.5,
                   ),
                 ),
                 SizedBox(
                   width: 22.w,
                 ),
                 GestureDetector(
                     onTap: () {
                     },
                     child: CustomButtonN(
                       labelText: 'login_guest'.tr(),
                       sizeButton: 2.5,
                     )),
               ],
             ),
           ),
         ],
       ),
     ),
    );
  }
}
