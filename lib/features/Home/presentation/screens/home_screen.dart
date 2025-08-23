import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Widgets/custom_card.dart';
import 'package:meal_app/core/routing/app_routes.dart';
// import 'package:meal_app/core/locator/service_locator.dart';
// import 'package:meal_app/features/Home/Domain/Repository/Repository.dart';
import 'package:meal_app/features/Home/presentation/Cubit/home_cubit.dart';

import 'package:meal_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/Widgets/custom_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final userId = user?.id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userId != null) {
        context.read<FavoritesCubit>().loadFavorites(userId);
        context.read<HomeCubit>().fetchItems(userId);
      }
    });

    return BlocListener<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesLoaded) {
          print('Favorites loaded, triggering UI refresh');
          // Force rebuild of the entire widget tree if needed
          (context as Element).markNeedsBuild();
        }
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          } else if (state is HomeLoaded) {
            // final meals = state.items;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 10.h,
                children: [
                  CustomField(
                    hint: "Search Recipe",
                    label: "Search Recipe",
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.primary,
                    ),
                    suffixIcon: Icon(
                      Icons.filter_list_sharp,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  ),
                  InkWell(
                    // navigate to screen that you can add ingredients
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.geminiScreen);
                    },
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                          height: 35.h,
                          width: 160.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            "add your ingredients",
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Recipes",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        "see all",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: state.meals.length,
                      itemBuilder: (context, index) {
                        print(state.meals[index].id);
                        final meal = state.meals[index];
                        return CustomCard(
                          meal: meal,
                          onPressed: () async {
                            if (userId != null) {
                              await context
                                  .read<FavoritesCubit>()
                                  .toggleFavorite(userId, meal);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please sign in to add favorites',
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(child: Text("No mealsfound"));
        },
      ),
    );
  }
}
