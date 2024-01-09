
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_app/controllers/authentication_controller.dart';
import 'package:language_app/controllers/signin_controller.dart';
import 'package:language_app/core/styles/colors.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/views/screens/rest_password_screen.dart';
import 'package:language_app/views/screens/signup_screen.dart';
import 'package:language_app/views/widgets/button.dart';
import 'package:language_app/views/widgets/input.dart';


import 'package:provider/provider.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final myController1 = TextEditingController();

  final myController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthController>(context,listen: false);
    final signinProvider =  Provider.of<SigninController>(context,listen: false);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [         
                        const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(style: AppTextStyle.titleTextStyle,"Sign In")),
                        const SizedBox(height: 15,),
                         InputText(hint: "Adresse Email",type: TextInputType.emailAddress,controler: signinProvider.loginEmail,validator:(v)=>authProvider.validEmail(v??""),),
                        const SizedBox(height: 10,),
                        InputText(hint: "Mot de passe",obs: Provider.of<SigninController>(context).obs,icon:Icon(Provider.of<SigninController>(context).icon),click: () => Provider.of<SigninController>(context,listen: false).visibilite(),controler: signinProvider.loginPassword,validator:(v)=> authProvider.validPassword(v??"")),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const ResetPasswordScreen()));}, child: Text('Mot de passe oublié ?',style: TextStyle(color:AppColors.darkGrey2,fontSize: 12.sp)
                          ,)),
                        ),
                        const SizedBox(height: 20,),
                        MyButton(text: 'Se connecter',click: () {
                                   if(!_formKey.currentState!.validate()){
                                          return;
                            }                
                           _formKey.currentState!.save();
                          authProvider.login(signinProvider.loginEmail.text.toString(), signinProvider.loginPassword.text.toString(), context).then((value) => signinProvider.clearFields());
                          
                        },),
                           const SizedBox(height: 20,),  
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Vous n'avez pas de compte,", textAlign: TextAlign.center),
                            TextButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) =>  SignupScreen()));
                            }, child:const Text ('Inscrivez-vous ?',style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.bold),
                            ),
                        )],
                        )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }}
