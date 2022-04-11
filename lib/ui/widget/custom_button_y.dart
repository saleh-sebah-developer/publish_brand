import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomButtonY extends StatelessWidget {
  String labelText;
  double sizeButton = 2.5;

  CustomButtonY({this.labelText, this.sizeButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / sizeButton,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: HexColor('#4091AF'),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(

        child: Text(
          labelText,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'TajawalRegular'),
        ),
      ),
    );
  }
}
