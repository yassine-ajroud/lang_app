import 'package:flutter/material.dart';
import 'package:language_app/controllers/course_controller.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/models/section.dart';
import 'package:language_app/views/screens/language_screen.dart';
import 'package:language_app/views/screens/quizz_screen.dart';
import 'package:language_app/views/widgets/button.dart';
import 'package:language_app/views/widgets/exit_dialog.dart';
import 'package:language_app/views/widgets/lecture_item.dart';
import 'package:provider/provider.dart';

class SectionScreen extends StatelessWidget {
  final Section section;
  const SectionScreen({super.key,required this.section});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.white,
       appBar: AppBar(elevation: 0,backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      leading: IconButton(onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> LangugaeScreen(languageID:Provider.of<CourseController>(context).currentLanguage.id)));}, icon:const Icon(Icons.arrow_back,color: AppColors.black,)),
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
        future: Provider.of<CourseController>(context,listen: false).getLectures(section),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                     Text( section.title,style:AppTextStyle.titleTextStyle ,),
                    const SizedBox(height: 20,),
                   // LectureItem()
                     ListView(
            shrinkWrap: true,
            children:List<Widget>.generate(Provider.of<CourseController>(context).currentLecture.length, (i) =>  LectureItem(lecture: Provider.of<CourseController>(context).currentLecture.firstWhere((element) => element.order==i+1),)).toList(),
                     ),
           const Spacer(),
                    Align(
             alignment: Alignment.bottomRight,
             child: MyButton(text: "Quizz", click: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>QuizzScreen(section: section)));}),
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