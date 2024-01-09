import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_app/models/quizz.dart';

class QuizzController with ChangeNotifier{
  late Quizz currentQuizz;
  late List<String> answers=[];
  String radioValue='';

   CollectionReference quizz = FirebaseFirestore.instance.collection('quizz');

   void setValue(String newValue){
    radioValue=newValue;
    notifyListeners();
   }

  Future<bool> getQuizz(String quizzID)async{
final qz = await quizz.doc(quizzID).get();
 currentQuizz = Quizz.fromJson(qz.data() as Map<String,dynamic>);
 generateQuizz(currentQuizz);
 return true;
  } 

  void generateQuizz(Quizz quizz){
    answers = quizz.wrong.map((e) => e.toString()).toList();
    answers.shuffle(Random());
    int rand = Random().nextInt(3);
    answers[rand]=quizz.right;
  }
}