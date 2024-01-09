
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/core/styles/text_styles.dart';

class MyButton extends StatelessWidget {
  
  final String text ;
  final void Function() click;
  const MyButton({super.key, required this.text ,required this.click});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: 130.w,
                height: 50.h,
                child: ElevatedButton(onPressed:click,style: ButtonStyle(backgroundColor:MaterialStateProperty.all(AppColors.primary),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(color :AppColors.primary)
                  )
                )), child: Text(text,style: AppTextStyle.buttonTextStyle)
                ),
              )
      

    ;
  }
}