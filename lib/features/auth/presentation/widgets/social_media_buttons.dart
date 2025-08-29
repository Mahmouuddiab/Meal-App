import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/app_images.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 53.w,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.blue,
          radius: 30.r,
          child: Image.asset(AppImages.facebook, height: 40.h),
        ),

        CircleAvatar(
          backgroundColor: AppColors.white,
          radius: 30.r,
          child: Image.asset("assets/images/Google.png", height: 40.h),
        ),
      ],
    );
  }
}
