import 'package:flutter/material.dart';
import 'package:metex_app/utils/utils.dart';

class ConstantData{
   static String assetsImagePath = "assets/images/";


  static Color bgColor = "#FBFBFB".toColor();
  static Color textColor1 = "#293040".toColor();
  static Color whiteColor = "#FFFFFF".toColor();
  static  Color dangerColor = "#e91e63".toColor();
  static  Color blueColor = "#0a72c7".toColor();
   static Color viewColor = "#CCCCCC".toColor();
  

  

  
  static  Color primaryColor = "#1d0f4d".toColor();
 
  static Color textColor = Colors.black54;
  static Color primaryTextColor = "#3F3F41".toColor();
  static Color kGreyTextColor = Color(0xFF828282);

 static Color active = Color(0xFF3C19C0);
 static Color light = Color(0xFFF7F8FC);
static  Color lightGrey = Color(0xFFA4A6B3);
static Color grey = "#d8d0d01".toColor();

static Color cellColor = "#E4E6ED".toColor();
static Color lightPrimaryColors = "#ECEDFA".toColor();
static Color shadowColor = Colors.transparent;
 static Color redColor = Colors.red;




 //static String fontFamily = "SFProText";
 static String fontFamily = "Sukhumvit Set Text";
 static double font12Px = SizeConfig.safeBlockVertical! / 0.75;
  static double font15Px = SizeConfig.safeBlockVertical! / 0.6;
  static double font18Px = SizeConfig.safeBlockVertical! / 0.5;
}


extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}