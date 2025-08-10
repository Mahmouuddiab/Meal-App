import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Utils/app_colors.dart';

class CustomField extends StatelessWidget {
  final String hint;
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  const CustomField({
    super.key,
    required this.hint,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
     this.obscureText,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      cursorColor: AppColors.white,
      style: TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.gray, width: 1.5.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5.w),
        ),
        hintText: hint,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: TextStyle(color: AppColors.primary,fontWeight: FontWeight.w600),
        labelStyle: TextStyle(color: AppColors.primary,fontWeight: FontWeight.w600),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon
      ),
      controller: controller,
      obscureText: obscureText ?? false,
      validator: validator,
    );
  }
}
