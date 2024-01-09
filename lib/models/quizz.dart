import 'package:equatable/equatable.dart';

class Quizz extends Equatable{
  final String question;
  final String right;
  final List<dynamic> wrong;
  
  const Quizz({required this.question,required this.right,required this.wrong});

  @override
  List<Object?> get props => [question,right,wrong];

 factory Quizz.fromJson(Map<String,dynamic> json)=>Quizz(question: json['question'], right: json['right'], wrong: json['wrong']);
}