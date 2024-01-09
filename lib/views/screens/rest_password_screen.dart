
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:language_app/controllers/authentication_controller.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/views/widgets/button.dart';
import 'package:provider/provider.dart';
import '../Widgets/input.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context,listen: false);
        final provider1 = Provider.of<AuthController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white10,elevation: 0,leading: IconButton(onPressed: (){Navigator.of(context).pop();}, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),),
        body: Container(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
 
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      style: AppTextStyle.titleTextStyle,"Reset Password"),
                  ),
                ),
                const SizedBox(height: 20,),
                  
                 Form(
                     key: _formKey,
                  child: InputText(hint: "Email",type: TextInputType.emailAddress,controler: provider1.resetPasswordEmail,validator:(v)=>provider.validEmail(v??""),)),
                   const SizedBox(height: 20,),
           
                     
                MyButton(text: 'Send',click: () {
                           if(!_formKey.currentState!.validate()){
                                  return;
                    }                
                   _formKey.currentState!.save();
                  provider.resetPassword( email:provider1.resetPasswordEmail.text.toString()).then((value) => Fluttertoast.showToast(
        msg: "Lien de réinitialisation de mot de passe envoyé ! vérifie ton email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    ));
                  
                },),
                      
              
            ]),
          ),
        ),
      ),
    );
  }}
