import 'package:flutter/material.dart';
class SigninController with ChangeNotifier {
  TextEditingController loginEmail=TextEditingController();
  TextEditingController loginPassword =TextEditingController();


  bool check = false;
  IconData icon = Icons.visibility;
  bool obs = true;
  void checking (c){
    check = c;
    notifyListeners();
  }
  void visibilite (){
    if(obs){
      obs=false;
      icon=Icons.visibility_off;
    }else{
      obs=true;
      icon=Icons.visibility;
    }notifyListeners();
  } 

  void clearFields(){
    loginEmail.clear();
    loginPassword.clear();
  }
}