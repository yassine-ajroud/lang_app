
import 'package:flutter/material.dart';
import 'package:language_app/controllers/authentication_controller.dart';
import 'package:language_app/core/styles/text_styles.dart';
import 'package:language_app/views/screens/login_screen.dart';
import 'package:language_app/views/widgets/button.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class DisconnectDialog extends StatelessWidget {
    DisconnectDialog({super.key});

   TextEditingController editingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
                final authProvider = Provider.of<AuthController>(context,listen: false);

    return  AlertDialog(
    title: const Text('Disconnect'),
    titleTextStyle:AppTextStyle.secondaryBlackTitleTextStyle,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    actions: 
    [
      TextButton(child: Text( 'Delete Account',style: AppTextStyle.greyTitleTextStyle,), onPressed:(){
        showDialog(context: context, builder: (_)=>AlertDialog(title: const Text('Delete Account'),content: TextFormField(controller: editingController,obscureText: true,decoration:const InputDecoration(hintText: "Password"),),
        actions: [MyButton(text: 'Delete', click: ()async{
          if(editingController.text!=''){

try {
              authProvider.deleteUser(editingController.text).then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const LoginScreen())));
} catch (e) {
  
}

          }
        })],));
      } ),
      MyButton(text: 'Logout', click:()async{
      await authProvider.logout().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const LoginScreen())));

      } ),
    ],
    );
  }
}