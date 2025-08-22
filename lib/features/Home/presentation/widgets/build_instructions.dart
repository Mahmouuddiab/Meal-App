import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Models/meal_model.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/strings.dart';

Widget buildInstructionsTab({required Meal meal}) {
  return Padding(
    padding: EdgeInsets.all(16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.totalSteps} ${meal.stepsList.isEmpty ? '0' : meal.stepsList.length.toString()}',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: meal.stepsList.isEmpty ? 0 : meal.stepsList.length,
          itemBuilder: (context, index) {
            return _buildStepItem(
              '${index + 1}',
              meal.stepsList[index].description,
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildStepItem(String stepNumber, String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '${AppStrings.step} $stepNumber',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
      SizedBox(height: 8.h),
      Text(
        description,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.primary,
          height: 1.5,
        ),
      ),
      SizedBox(height: 16.h),
    ],
  );
}
