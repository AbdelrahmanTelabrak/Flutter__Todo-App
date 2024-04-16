import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget basicFormField(
    {required String hint,
      required FormFieldValidator validator,
      Function(String)? onChanged}) {
  return TextFormField(
    maxLines: 1,
    validator: validator,
    onChanged: onChanged,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 16,
        color: Color(0xffADA4A5),
      ),
      filled: true,
      fillColor: const Color(0xffF7F8F8),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
      errorStyle: const TextStyle(height: 0),
    ),
  );
}