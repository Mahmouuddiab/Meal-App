import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Utils/app_colors.dart';

class CustomLoginWith extends StatelessWidget {
  const CustomLoginWith({super.key,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10.w,
      children: [
        Container(height: 1.h, width: 92.w, color: Colors.white),
        Text(
          "or login with",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
        Container(height: 1.h, width: 92.w, color: Colors.white),
      ],
    );
  }
}
