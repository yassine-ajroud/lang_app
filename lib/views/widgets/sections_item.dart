import 'package:flutter/material.dart';
import 'package:language_app/controllers/authentication_controller.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/models/section.dart';
import 'package:language_app/views/screens/section_screen.dart';
import 'package:provider/provider.dart';

class SectionItem extends StatelessWidget {

 final Section section;
  const SectionItem({super.key,required this.section});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(Provider.of<AuthController>(context,listen: false).currentUser.sections.contains(section.id)){
Navigator.of(context).push(MaterialPageRoute(builder: (_)=> SectionScreen(section: section,)));
        }

      },
      child: Padding(
        padding: const EdgeInsets.only(bottom:15.0),
        child: Container(
         // height: 70.h,
          decoration: BoxDecoration(
            color: AppColors.lightgrey,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              RichText(text: TextSpan(children: [TextSpan(text:'Section ${section.order}: ',style: AppTextStyle.greyTitleTextStyle),TextSpan(text:section.title,style:  Provider.of<AuthController>(context).currentUser.sections.contains(section.id) ? AppTextStyle.blackTitleTextStyle:AppTextStyle.disabledTitleTextStyle)])),
              const Icon(Icons.arrow_forward_outlined)
            ],),
          ),
        ),
      ),
    );
  }
}