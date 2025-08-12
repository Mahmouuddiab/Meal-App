import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Models/Meal_Model.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/app_images.dart';

class CustomFavoritesCard extends StatelessWidget {
  CustomFavoritesCard({super.key, required this.meal});

  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      width: 368.w,
      height: 119.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGray),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 12.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 41.r,
              backgroundImage: AssetImage(meal.imageUrl),
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.category,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 15.sp,
                          ),
                        ),
                        Text(
                          meal.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 55.w),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: AppColors.primary,
                        size: 26.h,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      meal.subtitle,
                      style: TextStyle(
                        color: AppColors.textGray,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      meal.time,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 18.h),
                    Icon(Icons.star, color: Colors.orange, size: 18.h),
                    Icon(Icons.star, color: Colors.orange, size: 18.h),
                    Icon(Icons.star, color: Colors.orange, size: 18.h),
                    Icon(Icons.star, color: Colors.orange, size: 18.h),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
