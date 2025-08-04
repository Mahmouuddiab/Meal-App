import 'package:flutter/material.dart';
import 'package:meal_app/core/Utils/app_images.dart';

import '../../../../core/Utils/app_colors.dart';


class LogoCircleAvatar extends StatelessWidget{
  const LogoCircleAvatar({super.key});


  @override
  Widget build(BuildContext context){
    return CircleAvatar(
      backgroundColor:AppColors.white,
      radius: 54 ,
      child: CircleAvatar(
        radius: 49,
        backgroundColor: AppColors.primary,
        child: Image.asset(AppImages.logo)
      ),
    );
  }
}