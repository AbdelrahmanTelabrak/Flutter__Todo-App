import 'package:flutter/material.dart';

Widget regularText(String txt, {double fontSize = 16, Color color = Colors.black}){
  return Text(
    txt,
    style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        color: color
    ),
  );
}

Widget mediumText(String txt, {double fontSize = 16, Color color = Colors.black}){
  return Text(
    txt,
    style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: color
    ),
  );
}
Widget semiBoldText(String txt, {double fontSize = 16, Color color = Colors.black, TextAlign? align}){
  return Text(
    txt,
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
    textAlign: align,
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
    ),
  );
}
Widget boldText(String txt, {double fontSize = 16, Color color = Colors.black, TextAlign? align}){
  return Text(
    txt,
    textAlign: align,
    style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        color: color
    ),
  );
}
