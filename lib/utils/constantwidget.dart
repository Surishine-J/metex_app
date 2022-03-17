

import 'package:flutter/material.dart';
import 'package:metex_app/utils/utils.dart';

class ConstantWidget {
  /*static void showCustomToast(String texts, BuildContext context) {
  Toast.show(texts, context,
      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
}*/

  final textStyleTabbar = TextStyle(
  color: ConstantData.whiteColor,
  fontWeight: FontWeight.bold,
  fontSize: ConstantData.font18Px,
  fontFamily: ConstantData.fontFamily
);

  static Widget getUnderLineCustomTextWithoutAlign(
      String text, Color color, FontWeight fontWeight, double fontSize) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: ConstantData.fontFamily,
          decoration: TextDecoration.underline,
          fontWeight: fontWeight),
    );
  }

  static Widget getCustomText(String text, Color color, int maxLine,
      TextAlign textAlign, FontWeight fontWeight, double textSizes) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize:14,
          color: color,
          fontFamily: ConstantData.fontFamily,
          fontWeight: fontWeight),
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }

  static Widget getCustomTextWithoutAlign(
      String text, Color color, FontWeight fontWeight, double fontSize) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: ConstantData.fontFamily,
          decoration: TextDecoration.none,
          fontWeight: fontWeight),
    );
  }

   static Widget getCustomTextIconWithoutAlign(
      Icon icon,String text, Color color, FontWeight fontWeight, double fontSize) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: ConstantData.fontFamily,
          decoration: TextDecoration.none,
          fontWeight: fontWeight),
    );
  }

  static Text getCustomTextTabbar(
      String text, Color color, FontWeight fontWeight, double fontSize) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: ConstantData.fontFamily,
          decoration: TextDecoration.none,
          fontWeight: fontWeight),
    );
  }

  static Widget getAppBarText(String s) {
    return ConstantWidget.getCustomTextWithoutAlign(
        s, ConstantData.textColor1, FontWeight.bold, ConstantData.font18Px);
    // return       ConstantWidget.getCustomTextWithoutAlign(S.of(context).checkOut, ConstantData.textColor, FontWeight.bold, ConstantData.font18Px),
  }

  static Widget getAppBarIcon() {
    return Icon(
      Icons.arrow_back_ios_sharp,
      color: ConstantData.textColor1,
    );
    // return       ConstantWidget.getCustomTextWithoutAlign(S.of(context).checkOut, ConstantData.textColor, FontWeight.bold, ConstantData.font18Px),
  }

  static double getScreenPercentSize(BuildContext context, double percent) {
    return (MediaQuery.of(context).size.height * percent) / 100;
  }

  static double getPercentSize1(double total, double percent) {
    return (total * percent) / 100;
  }

  static double getPercentSize(double total, int percent) {
    return (total * percent) / 100;
  }

  static Widget getSpace(double space) {
    return SizedBox(
      height: space,
    );
  }
  static Widget getSpaceWidth(double space) {
    return SizedBox(
      width: space,
    );
  }

  static Widget getSpace1() {
    return Spacer();
  }
}
