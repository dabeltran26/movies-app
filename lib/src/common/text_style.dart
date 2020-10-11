import 'package:flutter/material.dart';
import 'package:movies_app/src/common/colors.dart';

class GeneralTextStyles{

  static TextStyle tittleBold = const TextStyle(
    color: GeneralColors.white,
    fontSize: 26,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontFamily: 'Open Sans'
  );

  static TextStyle menuTittle = const TextStyle(
      color: GeneralColors.white,
      fontSize: 13,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: 'Open Sans'
  );
}