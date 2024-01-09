import 'package:flutter/material.dart';
import 'package:language_app/controllers/quizz_controller.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AnswerItem extends StatefulWidget {
   String value;
   AnswerItem({super.key,required this.value});

  @override
  State<AnswerItem> createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
             border: Border.all(
        width: 1,
        color: AppColors.black
      ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(widget.value,style: AppTextStyle.secondaryBlackTitleTextStyle,),Radio(activeColor: AppColors.primary,value: widget.value, groupValue: Provider.of<QuizzController>(context).radioValue, onChanged: (v){ Provider.of<QuizzController>(context,listen: false).setValue(v!);})]),
        ),
      ),
    );
  }
}