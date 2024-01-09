// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:language_app/controllers/authentication_controller.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/views/screens/home_screen.dart';
import 'package:language_app/views/screens/login_screen.dart';

import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();

}
class _SplashScreenState extends State<SplashScreen>{
  @override
 void initState(){
    super.initState();
    Timer(const Duration(seconds: 3),() async{
FirebaseAuth.instance
  .userChanges()
  .listen((User? user) async{
    if (user == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_) => const LoginScreen()));
    } else {
       await  Provider.of<AuthController>(context,listen: false).getCurrentUser( user.uid);
             Provider.of<AuthController>(context,listen:false).userId =user.uid;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_) => const HomeScreen()));
    }
  });

  });
  }
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>( AppColors.primary),
          ),
           SizedBox(height: 20,),
           Text("Loading...",textAlign: TextAlign.center,style: TextStyle(color: AppColors.primary,fontSize: 12,fontWeight: FontWeight.bold),)
          
          
        ],
        ),
      ),
      

    );
  }
}
