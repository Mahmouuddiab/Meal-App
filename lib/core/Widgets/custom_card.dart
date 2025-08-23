import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Models/meal_model.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/app_images.dart';
import 'package:meal_app/core/Widgets/custom_favorite_button.dart';
import 'package:meal_app/core/routing/app_routes.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_state.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.meal,
    required this.onPressed,
    this.isInitiallyFavorite = false,
  });

  final Meal meal;
  final VoidCallback onPressed;
  final bool isInitiallyFavorite;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return GestureDetector(
          onTap:
              () => Navigator.pushNamed(
                context,
                AppRoutes.mealDetails,
                arguments: meal,
              ),
          child: Container(
            margin: EdgeInsets.only(bottom: 15.h),
            width: 368.w,
            height: 119.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderGray),
              color: AppColors.white,
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
                    backgroundColor: AppColors.white,
                    backgroundImage:
                        meal.imageUrl == ""
                            ? AssetImage(AppImages.noImage)
                            : NetworkImage(meal.imageUrl),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                SizedBox(
                                  width: 120.w,
                                  child: Text(
                                    meal.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            CustomFavoriteIconButton(meal: meal),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${meal.ingredientsList.length} ingredients',
                              style: TextStyle(
                                color: AppColors.textGray,
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              '${meal.time}min',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 20.h),
                            Text(
                              meal.rating.toString(),
                              style: TextStyle(
                                color: AppColors.textGray,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
