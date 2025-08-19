import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Models/meal_model.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/strings.dart';

Widget buildSummaryTab({required Meal meal}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          meal.summary == '' ? 'There should be a summary here' : meal.summary,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          AppStrings.nutrition,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 16.h),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
          ),
          itemCount: meal.nutritionList.length,
          itemBuilder: (context, index) {
            final nutrition = meal.nutritionList[index];
            return _buildNutritionCircle(
              '${nutrition.value} ${nutrition.unit}',
              nutrition.name,
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildNutritionCircle(String value, String label) {
  return Column(
    children: [
      Container(
        width: 90.w,
        height: 90.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 4.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 14.sp, color: AppColors.primary),
            ),
          ],
        ),
      ),
    ],
  );
}
