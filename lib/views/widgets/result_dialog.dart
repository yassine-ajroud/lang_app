
import 'package:flutter/material.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/models/section.dart';
import 'package:language_app/views/screens/language_screen.dart';
import 'package:language_app/views/screens/section_screen.dart';
import 'package:language_app/views/widgets/button.dart';


class ResultDialog extends StatelessWidget {
 final String languageId;
  final bool correct;
  final Section section;
   const ResultDialog({super.key,required this.correct,required this.languageId,required this.section});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
    title:  Text(correct? 'Correct!': 'Incorrect!'),
    titleTextStyle:correct?AppTextStyle.correctTextStyle:AppTextStyle.incorrectTextStyle,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    actions: [MyButton(text: 'Next', click:(){
     correct? Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>LangugaeScreen(languageID: languageId))):Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>SectionScreen(section: section,)))  ;
    } )],
    );
  }
}