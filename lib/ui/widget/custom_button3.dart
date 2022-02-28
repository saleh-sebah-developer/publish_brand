import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomButton3 extends StatelessWidget {
  String labelText;
  double sizeButton = 2.5;

  CustomButton3({this.labelText, this.sizeButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / sizeButton,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: HexColor('#145366'),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        labelText,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontFamily: 'TajawalRegular'),
      ),
    );
  }
}
