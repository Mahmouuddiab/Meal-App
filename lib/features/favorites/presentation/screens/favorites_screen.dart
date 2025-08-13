import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Widgets/custom_card.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    final user = Supabase.instance.client.auth.currentUser;
    final userId = user?.id;
    if (userId != null) {
      context.read<FavoritesCubit>().loadFavorites(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final userId = user?.id;
    print(userId);

    if (userId == null) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: Center(child: Text('Please sign in')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: AppColors.unselectedGray,
                    ),
                    SizedBox(height: 16.h),
                    Text('No favorites yet'),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(8.w),
              itemCount: state.favorites.length,
              itemBuilder: (_, i) {
                final meal = state.favorites[i];
                return CustomCard(
                  meal: meal,
                  onPressed: () async {
                    await context.read<FavoritesCubit>().toggleFavorite(
                      userId,
                      meal,
                    );
                  },
                );
              },
            );
          } else if (state is FavoritesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: _loadFavorites,
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is FavoritesUpdating) {
            return Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: state.favorites.length,
                  itemBuilder: (_, i) {
                    final meal = state.favorites[i];
                    return CustomCard(
                      meal: meal,
                      onPressed: () async {
                        await context.read<FavoritesCubit>().toggleFavorite(
                          userId,
                          meal,
                        );
                      },
                    );
                  },
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 2.h,
                    child: LinearProgressIndicator(),
                  ),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
