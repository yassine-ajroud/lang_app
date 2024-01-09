import 'package:equatable/equatable.dart';

class Section extends Equatable{
  final String title;
  final int order;
  final List<dynamic> lectures;
  final String quizz;
  final String id;
  
 const Section({required this.lectures,required this.order, required this.quizz,required this.title , required this.id});

  @override
  List<Object?> get props => [title,order,lectures,quizz,id];

  factory Section.fromJson(Map<String,dynamic> json)=>Section(lectures: json['lectures'], 
  id: json['id'],
  order: json['order'], 
  quizz: json['quizz'], 
  title: json['title']);

}