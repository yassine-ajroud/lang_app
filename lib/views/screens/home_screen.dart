import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/views/widgets/exit_dialog.dart';
import 'package:language_app/views/widgets/language_Item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(elevation: 0,backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      actions: [
       
        IconButton(onPressed: ()async{
          showDialog(context: context, builder: (_)=>DisconnectDialog());
          },
           icon:const Icon(Icons.exit_to_app,color: AppColors.red,))
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(
              width: 250.w,
              child: Text.rich(TextSpan(children: [TextSpan(text:"which",style: AppTextStyle.secondaryTitleTextStyle),TextSpan(text:" language ",style: AppTextStyle.titleTextStyle),TextSpan(text:"you want to learn?",style: AppTextStyle.secondaryTitleTextStyle)]))),
              SizedBox(height: 30.h,),
             const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LanguageItem(language: "English",image: "assets/britain.png",id:'1EdIQ5sVm5hOuvMvhqkn'),
                  LanguageItem(language: "French",image: "assets/france.png",id:'s5JKLYtIcCfzauAmMD0y'),
                ],
              ),
              SizedBox(height:30.h),
              const LanguageItem(language: "Spanish",image: "assets/spain.png",id:'UqXWuBeQQO9t0pv7Qpdk'),
          ]),
        ),
      ),
    ));
  }
}