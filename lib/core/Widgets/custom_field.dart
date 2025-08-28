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
  final TextStyle? style;
  final void Function(String)? onChanged;
  final void Function()? onTap;
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
    this.style,
    this.onChanged,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      keyboardType: keyboardType,
      cursorColor: AppColors.primary,
      style: style,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.gray, width: 1.5.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.gray, width: 1.5.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.gray, width: 1.5.w),
        ),
        hintText: hint,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: style?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        labelStyle: style?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon
      ),
      controller: controller,
      obscureText: obscureText ?? false,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
