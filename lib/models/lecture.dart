import 'package:equatable/equatable.dart';

class Lecture extends Equatable{
 final String video;
 final String title;
 final int order;

 const Lecture({required this.video,required this.title,required this.order});
  
  @override
  List<Object?> get props =>[video,title,order];

factory Lecture.fromJson(Map<String,dynamic> json)=>Lecture(video: json['video'], title: json['title'], order: json['order']);
}