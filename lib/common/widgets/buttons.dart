import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget fullWidthButton({required Widget child, Function()? onPressed}) {
  return DecoratedBox(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.transparent),
      color: const Color(0xff4A3780),
      borderRadius: BorderRadius.circular(100),
    ),
    child: MaterialButton(
      minWidth: double.infinity,
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: child,
    ),
  );
}

Widget catSelector({bool isSelected = false, required String iconPath}){
  return Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: isSelected? const Color(0xff4A3780): Colors.white),
    ),
    child: SvgPicture.asset(iconPath),
  );
}