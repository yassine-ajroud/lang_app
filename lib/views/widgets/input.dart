import 'package:flutter/material.dart';
import 'package:language_app/core/styles/colors.dart';

// ignore: must_be_immutable
class InputText extends StatelessWidget {
  final String hint;
   bool ? obs;
  final Icon ? icon;
  final void Function() ? click;
  final String? Function(String?)? validator;
  final TextEditingController? controler;
  final int ? length;
  final TextInputType ? type ;
   InputText({super.key, required this.hint,this.obs,this.icon,this.click,this.type,this.controler,this.validator,this.length});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: length,
      validator: validator,
      controller: controler,
    obscureText: obs ?? false,
    keyboardType: type ?? TextInputType.text,
      decoration: InputDecoration(
        hintText:hint,
            suffixIcon: obs != null?InkWell(onTap:click, child: icon):null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:const BorderSide(color: AppColors.black,
              width: 2.0)
            ),
            enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: AppColors.black,
                    width: 2.0,
                  ),
          ),
    ));
  }
}