

// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:language_app/models/user.dart';
import 'package:language_app/views/screens/home_screen.dart';

class AuthController with ChangeNotifier{
   List<UserModel> allusers=[];
   String userId='';
  late UserModel currentUser;

   //reset password  
   TextEditingController resetPasswordEmail=TextEditingController();
  String error="une erreur s'est produite";

  CollectionReference users = FirebaseFirestore.instance.collection('users');



//log into firabase with email and password  
Future<void> login(String email,String password,BuildContext ctx)async{
  try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  userId=credential.user!.uid;
  await getCurrentUser(userId);
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));                   
    print('logged in');
 } on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    error='Aucun utilisateur trouvé pour cet e-mail.';
  } else if (e.code == 'wrong-password') {
    error='Mauvais mot de passe fourni pour cet utilisateur.';
  }

Fluttertoast.showToast(
        msg: e.code,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );
} }

//create new firabase account
Future<void> createAccount(String email,String password,String username)async{
try {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  ).then((value) => {
     Fluttertoast.showToast(
        msg: "creation du compte",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    ),
      users
          .add({
            "id":value.user!.uid.toString(),
            "username":username,
            "email":email,
            "sections":['RziI4ehriYUHht0RqAYK'],
          })
          .then((value1) => {
            Fluttertoast.showToast(
        msg: "compte créé avec succès",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    ),
    users.doc(value1.id).update({'docID':value1.id})
    //print(value1)
          })
          .catchError((error) => print("Failed to add user: $error"))
    
  });
  
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    error='Le mot de passe fourni est trop faible.';
  } else if (e.code == 'email-already-in-use') {
    error='Le compte existe déjà pour cet e-mail.';
    Fluttertoast.showToast(
        msg: e.code,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
} catch (e) {
  print(e);
}
}

Future<void> updateUser(UserModel user)async{
 return users.doc(currentUser.docID).update(user.toJson());
}

Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .catchError((e) => Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    ));
  }

//log out from firebase
Future<void> logout()async{
  await FirebaseAuth.instance.signOut();  
}

Future<void> deleteUser(String password)async{
try {
  AuthCredential credential = EmailAuthProvider.credential(email: FirebaseAuth.instance.currentUser!.email!, password: password);
  await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
  await FirebaseAuth.instance.currentUser!.delete().then((value) => 
  users.doc(currentUser.docID).delete()
  );
} catch (e) {
  Fluttertoast.showToast(
        msg: "Can't delete account",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );}
}


Future<void> getAllUsers()async {
   QuerySnapshot querySnapshot = await users.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    allusers= allData.map((e) => UserModel.fromJSON(e as Map<String,dynamic>)).toList();

    print(allusers);
}

Future<void> getCurrentUser(String userID)async {
  await getAllUsers();
  currentUser = allusers.firstWhere((element) => element.id==userID);
}



String ?validuserName(String v){
  if (v.isEmpty) 
                    return "nom d'utilisateur obligatoire";
   return null;                 
}
String ?validEmail(String v){
  if (!v.contains("@gmail.com")||v.isEmpty) 
                    return "email n'est pas valide";
                       return null; 
}
String ?validPassword(String v){
  if (v.length<8||v.isEmpty) 
                    return 'longeur minimale:8';
                       return null; 
}
String ?validCPassword(String v,String v1){
  if (v.length<8||v.isEmpty||v!=v1) 
                    return 'le mot de passe ne correspond pas';
                       return null; 
}



}