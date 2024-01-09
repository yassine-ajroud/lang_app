
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:language_app/controllers/authentication_controller.dart';
import 'package:language_app/controllers/signup_controller.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/views/screens/login_screen.dart';
import 'package:language_app/views/widgets/dialog.dart';
import 'package:provider/provider.dart';


import '../../controllers/signin_controller.dart';

import '../widgets/button.dart';
import '../widgets/input.dart';

class SignupScreen extends StatefulWidget {
   SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthController>(context,listen: false);
    final signupProvider = Provider.of<SignupController>(context,listen: false);


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [         
                    const SizedBox(height: 20,),
                        
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(style: AppTextStyle.titleTextStyle,"Sign Up")),
                                            const SizedBox(height: 15,),
                     InputText(hint: "username",controler: signupProvider.username,validator: (v)=>authProvider.validuserName(v??""),),
                    const SizedBox(height: 10,),
                     InputText(hint: "Adresse Email",type: TextInputType.emailAddress,controler: signupProvider.email,validator: (v)=>authProvider.validEmail(v??"")),
                    const SizedBox(height: 10,),
                    InputText(hint: "Mot de passe",obs:Provider.of<SignupController>(context).obs,icon:Icon( Provider.of<SignupController>(context).icon),click: () => Provider.of<SignupController>(context,listen: false).visibilite(),controler: signupProvider.password,validator: (v)=>authProvider.validPassword(v??""),),
                    const SizedBox(height: 10,),
                    InputText(hint: "Confirmer Mot de passe",obs: Provider.of<SignupController>(context).obs,icon:Icon( Provider.of<SignupController>(context).icon),click: () => Provider.of<SignupController>(context,listen: false).visibilite(),controler: signupProvider.cpassword,validator: (v)=>authProvider.validCPassword(v??"",signupProvider.password.text.toString()),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      
                      Checkbox(activeColor:AppColors.primary, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),value:Provider.of<SigninController>(context).check, onChanged:(value)=>Provider.of<SigninController>(context,listen: false).checking(value),
                      
                      
                        
                       ),
                      const Text("J'ai lu et j'accepte"),

                      TextButton(onPressed: (){
                        showDialog(context: context, builder: (_) =>const MyDialog());
                      }, child:const Text ("les termes et les conditions.",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold),),)
                    ],),
                                                                  const SizedBox(height: 20,),
                    MyButton(text: 'Enregistrer',click: () async{
                                  if(!_formKey.currentState!.validate()){
                                    return;
                      }        
                      if(!Provider.of<SigninController>(context,listen: false).check){
Fluttertoast.showToast(
        msg: "tu dois accepter les terms et les conditions",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return;
                      }         
                      _formKey.currentState!.save();

                     await  Provider.of<AuthController>(context,listen: false).createAccount(signupProvider.email.text.toString(), signupProvider.password.text.toString(), signupProvider.username.text.toString()).then((value) {
                      signupProvider.clearFields();
                       return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const LoginScreen()));
                     }).onError((error, stackTrace) => print(error.toString()));

                    },),
                   
                      
                                                                  const SizedBox(height: 20,),

                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 6,),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Connecter a votre compte,", textAlign: TextAlign.center),
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child:const Text ("S'identifier ?",style: TextStyle(color:AppColors.primary,fontWeight: FontWeight.bold),
                          ),
                      )],
                      ),
                    )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}