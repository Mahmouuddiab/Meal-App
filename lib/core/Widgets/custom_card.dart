import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Models/Meal_Model.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/app_images.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        bool isFavorite = context.read<FavoritesCubit>().isFavorite(meal.id);

        return Container(
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
                  backgroundImage: AssetImage(AppImages.onboarding1),
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
                              Text(
                                meal.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              final user = Supabase.instance.client.auth.currentUser;
                              if (user?.id != null) {
                                await context
                                    .read<FavoritesCubit>()
                                    .toggleFavorite(user!.id, meal);
                              }
                            },
                            icon: isFavorite
                                ? Icon(
                                    Icons.favorite,
                                    color: AppColors.primary,
                                    size: 26.h,
                                  )
                                : Icon(
                                    Icons.favorite_outline,
                                    color: AppColors.unselectedGray,
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
                          Icon(Icons.star, color: Colors.orange, size: 18.h),
                          Icon(Icons.star, color: Colors.orange, size: 18.h),
                          Icon(Icons.star, color: Colors.orange, size: 18.h),
                          Icon(Icons.star, color: Colors.orange, size: 18.h),
                          Icon(Icons.star, color: Colors.orange, size: 18.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
