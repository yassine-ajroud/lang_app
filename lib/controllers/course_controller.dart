import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_app/models/language.dart';
import 'package:language_app/models/lecture.dart';
import 'package:language_app/models/section.dart';
class CourseController with ChangeNotifier {
  late Language currentLanguage;
  late List<Section> currentSections=[];
  late List<Lecture> currentLecture=[];


 CollectionReference languages = FirebaseFirestore.instance.collection('languages');
 CollectionReference sections = FirebaseFirestore.instance.collection('sections');
  CollectionReference lectures = FirebaseFirestore.instance.collection('lectures');


 Future<bool> getSections(String languge)async{
  currentSections=[];
  await getLanguge(languge);
  for (String section in currentLanguage.sections) {
    try {
       final sect = await sections.doc(section).get();
    currentSections.add(Section.fromJson(sect.data() as Map<String,dynamic>));
    // ignore: empty_catches
    } catch (e) {}
    
  }
  return true;
 }

String getNextSection(int order){
  return currentSections.firstWhere((element) => element.order==order).id;
}

 Future<void> getLanguge(String languge)async{
 final lang = await languages.doc(languge).get();
 currentLanguage = Language.fromJson(lang.data() as Map<String,dynamic>);
 }
 
 Future<bool> getLectures(Section section)async{
  currentLecture=[];
 
  for (String lecture in section.lectures) {
    try {
           final lect = await lectures.doc(lecture).get();
    currentLecture.add(Lecture.fromJson(lect.data() as Map<String,dynamic>));
    // ignore: empty_catches
    } catch (e) {}
 }
 return true;
 }
}