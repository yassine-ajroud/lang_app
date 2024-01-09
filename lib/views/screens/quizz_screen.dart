// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:language_app/controllers/authentication_controller.dart';
import 'package:language_app/controllers/course_controller.dart';
import 'package:language_app/controllers/quizz_controller.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/models/section.dart';
import 'package:language_app/views/screens/answer_item.dart';
import 'package:language_app/views/screens/section_screen.dart';
import 'package:language_app/views/widgets/button.dart';
import 'package:language_app/views/widgets/exit_dialog.dart';
import 'package:language_app/views/widgets/result_dialog.dart';
import 'package:provider/provider.dart';

class QuizzScreen extends StatelessWidget {
  final Section section;
    const QuizzScreen({super.key , required this.section});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.white,
     appBar: AppBar(elevation: 0,backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      leading: IconButton(onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> SectionScreen(section: section,)));}, icon:const Icon(Icons.arrow_back,color: AppColors.black,)),
      foregroundColor: AppColors.black,
      actions: [
         IconButton(onPressed: ()async{
          showDialog(context: context, builder: (_)=>DisconnectDialog());
          },
           icon:const Icon(Icons.exit_to_app,color: AppColors.red,))
      
      ],
      ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: FutureBuilder<bool>(
        future: Provider.of<QuizzController>(context,listen: false).getQuizz(section.quizz),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                     Text( 'Quizz',style:AppTextStyle.titleTextStyle ,),
                    const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(alignment: Alignment.center, child: Text( Provider.of<QuizzController>(context).currentQuizz.question,style:AppTextStyle.blackTitleTextStyle ,textAlign: TextAlign.center,)),
                      ),
                                          const SizedBox(height: 40,),
                     ListView(
            shrinkWrap: true,
            children:List<Widget>.generate(3, (i) =>  AnswerItem(value: Provider.of<QuizzController>(context).answers[i])).toList(),
                     ),
           const Spacer(),
                    Align(
             alignment: Alignment.bottomRight,
             child: MyButton(text: "Check", click: ()async{
              if(Provider.of<QuizzController>(context,listen: false).radioValue==Provider.of<QuizzController>(context,listen: false).currentQuizz.right){
                if(section.order+1<=Provider.of<CourseController>(context,listen: false).currentSections.length){
                  Provider.of<AuthController>(context,listen: false).currentUser.sections.add(Provider.of<CourseController>(context,listen: false).getNextSection(section.order+1));
                  await Provider.of<AuthController>(context,listen: false).updateUser(Provider.of<AuthController>(context,listen: false).currentUser);

                }
                showDialog(context: context, builder: (_)=>ResultDialog(correct: true, languageId: Provider.of<CourseController>(context,listen: false).currentLanguage.id, section: section),barrierDismissible: false);
              }else{
                showDialog(context: context, builder: (_)=>ResultDialog(correct: false, languageId: Provider.of<CourseController>(context,listen: false).currentLanguage.id, section: section),barrierDismissible: false);
              }
              Provider.of<QuizzController>(context,listen: false).setValue("");
             }),
            )
            ]);
          }else if(snapshot.connectionState==ConnectionState.waiting){
            return  const Center(
              child:  CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>( AppColors.primary),
            
              ),
            );
          }else{
            return  Center(child:  Text('error',style: AppTextStyle.secondaryTitleTextStyle,));
          }
          
        }
      ),
    ),
    ));
  }
}