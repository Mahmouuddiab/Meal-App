import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Models/meal_model.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomFavoriteIconButton extends StatelessWidget {
  const CustomFavoriteIconButton({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        bool isFavorite = context.read<FavoritesCubit>().isFavorite(meal.id);

        return IconButton(
          onPressed: () async {
            final user = Supabase.instance.client.auth.currentUser;
            if (user?.id != null) {
              await context.read<FavoritesCubit>().toggleFavorite(
                user!.id,
                meal,
              );
            }
          },
          icon:
              isFavorite
                  ? Icon(Icons.favorite, color: AppColors.primary, size: 26.h)
                  : Icon(
                    Icons.favorite_outline,
                    color: AppColors.unselectedGray,
                    size: 26.h,
                  ),
        );
      },
    );
  }
}
