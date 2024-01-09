import 'package:equatable/equatable.dart';

class Language extends Equatable{
final String id;
final String language;
final List<dynamic> sections;

 const Language({required this.language, required this.sections,required this.id});
 
  @override
  List<Object?> get props => [language,sections];

  factory Language.fromJson(Map<String,dynamic> json)=>Language(language: json['language'], sections: json['sections'],id: json['id']);
}