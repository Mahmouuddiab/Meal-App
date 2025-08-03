import 'package:flutter/material.dart';
import 'package:meal_app/core/Utils/app_colors.dart';

class CustomField extends StatelessWidget {
  String hint;
  Widget? prefixIcon;
  TextEditingController? controller;
  bool obscureText=false;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
   CustomField({
    required this.hint,
     this.prefixIcon,
     this.controller,
     required this.obscureText,
     this.validator,
     this.keyboardType
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,width: 2)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,width: 2)
          ),
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.white),
          prefixIcon: prefixIcon,
      ),
      controller:controller,
      obscureText: obscureText,
      validator: validator,
    );
  }
}
