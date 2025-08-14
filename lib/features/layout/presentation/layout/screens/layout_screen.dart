import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/features/layout/presentation/layout/cubit/layout_cubit.dart';
import 'package:meal_app/features/layout/presentation/layout/cubit/layout_states.dart';
import 'package:meal_app/features/layout/presentation/layout/widget/custom_bottom_nav_bar_item.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});
  final LayoutCubit layoutCubit = LayoutCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      bloc: layoutCubit,
      builder:
          (context, state) => Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              leading: Icon(Icons.menu, size: 30),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.notifications, size: 30),
                ),
              ],
            ),
            body: layoutCubit.tabs[layoutCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) => layoutCubit.changeBottomIndex(value),
              elevation: 0,
              backgroundColor: AppColors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: layoutCubit.currentIndex,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              items: [
                CustomBottomNavBarItem(Icon(Icons.home), "Home"),
                CustomBottomNavBarItem(Icon(Icons.favorite_border), "Favorite"),
                CustomBottomNavBarItem(Icon(Icons.person), "Profile"),
              ],
            ),
          ),
    );
  }
}
