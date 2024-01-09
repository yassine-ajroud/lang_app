import 'package:flutter/material.dart';
import 'package:language_app/controllers/course_controller.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/views/screens/home_screen.dart';
import 'package:language_app/views/widgets/exit_dialog.dart';
import 'package:language_app/views/widgets/sections_item.dart';
import 'package:provider/provider.dart';

class LangugaeScreen extends StatelessWidget {
  final String languageID;
  const LangugaeScreen({super.key,required this.languageID});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(elevation: 0,backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      leading: IconButton(onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const HomeScreen()));}, icon:const Icon(Icons.arrow_back,color: AppColors.black,)),
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
        future: Provider.of<CourseController>(context,listen: false).getSections(languageID),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
           Text( Provider.of<CourseController>(context).currentLanguage.language,style:AppTextStyle.titleTextStyle ,),
          const SizedBox(height: 20,),
           ListView(
            shrinkWrap: true,
            children:List<Widget>.generate(Provider.of<CourseController>(context).currentSections.length, (i) =>  SectionItem(section: Provider.of<CourseController>(context).currentSections.firstWhere((element) => element.order==i+1),)).toList(),
           )

          
            ]);
          }else if(snapshot.connectionState==ConnectionState.waiting){
            return  const Center(
              child:  CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>( AppColors.primary),
            
              ),
            );
          }else{
            return Text('error');
          }
          
        }
      ),
    ),
    ));
  }
}