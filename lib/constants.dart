import 'package:flutter/material.dart';

const double radius = 25.0;
Color greenColor = Colors.teal;

TextStyle whiteText = const TextStyle(color: Colors.white, fontSize: 15.0);

InputDecoration inputDecoration = InputDecoration(
  labelStyle: TextStyle(color: greenColor, fontSize: 18.0, fontWeight: FontWeight.w400),
  prefixIcon: Icon(Icons.place, color: greenColor),
  fillColor: Colors.white,
  filled: true,
  enabled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(color: greenColor),
  ),
  hoverColor: greenColor,
  errorMaxLines: 1,
  focusColor: greenColor,
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(color: greenColor, width: 2.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(color: greenColor, width: 2.0),
  ),
);