import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_app/core/styles/colors.dart';

class AppTextStyle {
  static TextStyle titleTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 36.sp, color: AppColors.primary);
  static TextStyle secondaryTitleTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 36.sp, color: AppColors.darkGrey2);
  static TextStyle whiteTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: AppColors.white,);
  static TextStyle greyTitleTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 15.sp, color: AppColors.darkGrey);
    static TextStyle blackTitleTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: AppColors.black);
    static TextStyle secondaryBlackTitleTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 18.sp, color: AppColors.black);

    static TextStyle disabledTitleTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: AppColors.darkGrey);

  static TextStyle buttonTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 15.sp, color: AppColors.white);
  static TextStyle correctTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: AppColors.primary);
    static TextStyle incorrectTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: AppColors.red);


      }