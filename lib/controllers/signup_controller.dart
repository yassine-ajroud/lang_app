import 'package:flutter/material.dart';
class SignupController with ChangeNotifier {
   TextEditingController username =TextEditingController();
   TextEditingController email =TextEditingController();
   TextEditingController password =TextEditingController();
   TextEditingController cpassword =TextEditingController();


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
    username.clear();
    email.clear();
    password.clear();
    cpassword.clear();
  }
}