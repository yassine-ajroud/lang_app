import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable{
final String  username,id,email,docID;
 List<dynamic> sections;


 UserModel({required this.sections,required this.id,required this.email,required this.username,required this.docID});

  @override
  List<Object?> get props => [username,id,email,sections,docID];

  factory UserModel.fromJSON(Map<String,dynamic>json){
    return UserModel(username: json['username'],
     id: json['id'],
     docID: json['docID'],
     email: json['email'],
     sections: json['sections']??[]);

  }  

  Map<String,dynamic> toJson()=>{
    'username':username,
    'id':id,
    'email':email,
    'sections':sections,
    'docId':docID
  };
}