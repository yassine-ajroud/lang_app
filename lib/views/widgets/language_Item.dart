import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/views/screens/language_screen.dart';

class LanguageItem extends StatelessWidget {
  final String image;
  final String  language;
  final String id;
  const LanguageItem({super.key,required this.image,required this.language,required this.id});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LangugaeScreen(languageID:id)));
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(image,width: 150.w,height: 150.h,fit: BoxFit.fill,color:AppColors.secondaryBlack,
              colorBlendMode: BlendMode.darken,)),
          Positioned(
            bottom: 10,
            child: Text(language,style: AppTextStyle.whiteTextStyle,))
        ],
      ),
    );
  }
}