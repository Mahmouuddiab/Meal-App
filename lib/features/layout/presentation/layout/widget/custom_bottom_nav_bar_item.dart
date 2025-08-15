import 'package:flutter/material.dart';
import 'package:meal_app/core/Utils/app_colors.dart';

class CustomBottomNavBarItem extends BottomNavigationBarItem{
  Icon icon;
  String title;
  CustomBottomNavBarItem(this.icon,this.title)
      :super(
    label: title,
    icon: icon,
    activeIcon: CircleAvatar(
      backgroundColor: AppColors.primary,
      child: icon,
      radius: 25,
      foregroundColor: AppColors.white,
    )
  );
}