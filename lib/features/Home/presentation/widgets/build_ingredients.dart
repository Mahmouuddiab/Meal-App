import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Models/meal_model.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/strings.dart';

Widget buildIngredientsTab({required Meal meal}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 31.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 21.h),

        Text(
          '${AppStrings.totalIngredients} ${meal.ingredientsList.length}',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 27.h),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: meal.ingredientsList.length,
          itemBuilder: (context, index) {
            final ingredient = meal.ingredientsList[index];
            return _buildIngredientItem(
              ingredient.name,
              ingredient.quantity,
              ingredient.imageUrl,
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildIngredientItem(String name, String quantity, String imageUrl) {
  return Column(
    children: [
      Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.unselectedGray,
            ),
            child: ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.restaurant_menu, color: AppColors.white);
                },
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          Text(
            quantity,
            style: TextStyle(fontSize: 18.sp, color: AppColors.primary),
          ),
        ],
      ),
      SizedBox(height: 15.h),
      Divider(color: AppColors.primary, thickness: 1.5),
      SizedBox(height: 15.h),
    ],
  );
}
