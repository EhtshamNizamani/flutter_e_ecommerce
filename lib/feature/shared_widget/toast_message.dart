import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static void showCustomToast(
      {String? message,
      Color? backgroundColor,
      String? webColor,
      Color? textColor}) {
    Fluttertoast.showToast(
      msg: message ?? '',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      webPosition: "center",
      webBgColor: webColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 12.sp,
    );
  }
}
