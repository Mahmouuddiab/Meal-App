import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/locator/service_locator.dart';
// import 'package:meal_app/core/routing/app_routes.dart';
import 'package:meal_app/features/layout/presentation/layout/cubit/layout_cubit.dart';
import 'package:meal_app/features/layout/presentation/layout/cubit/layout_states.dart';
import 'package:meal_app/features/layout/presentation/layout/widget/custom_bottom_nav_bar_item.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});
  final LayoutCubit layoutCubit = serviceLocator<LayoutCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => layoutCubit,
      child: BlocBuilder<LayoutCubit, LayoutStates>(
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
                  CustomBottomNavBarItem(
                    Icon(Icons.favorite_border),
                    "Favorite",
                  ),
                  CustomBottomNavBarItem(Icon(Icons.person), "Profile"),
                ],
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: (){
              //     Navigator.pushNamed(context, AppRoutes.geminiScreen);
              //   },
              //   backgroundColor: AppColors.primary,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(25)
              //   ),
              //   child: Text("Gemini",style: TextStyle(
              //       color: AppColors.white,
              //       fontWeight: FontWeight.bold
              //   ),),
              // ),
            ),
      ),
    );
  }
}
