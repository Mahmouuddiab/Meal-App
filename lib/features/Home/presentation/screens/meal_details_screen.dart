import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Models/meal_model.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/app_images.dart';
import 'package:meal_app/core/Utils/strings.dart';
import 'package:meal_app/core/Widgets/custom_favorite_button.dart';
import 'package:meal_app/features/Home/presentation/widgets/build_ingredients.dart';
import 'package:meal_app/features/Home/presentation/widgets/build_instructions.dart';
import 'package:meal_app/features/Home/presentation/widgets/build_summary.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_state.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({super.key, required this.meal});
  final Meal meal;

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
            leadingWidth: double.infinity,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                CustomFavoriteIconButton(meal: widget.meal),
              ],
            ),
          ),
          backgroundColor: AppColors.white,
          body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Image(
                  image:
                      widget.meal.imageUrl == ""
                          ? AssetImage(AppImages.noImage)
                          : NetworkImage(widget.meal.imageUrl),
                  fit: BoxFit.cover,
                  height: 235.h,
                ),
                Text(
                  widget.meal.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28.sp,
                  ),
                ),
                Text(
                  '${widget.meal.category == '' ? 'meat' : widget.meal.category} . ${widget.meal.time}min . ${widget.meal.servings} ${AppStrings.serving}',
                  style: TextStyle(color: AppColors.textGray, fontSize: 18.sp),
                ),
                TabBar(
                  controller: _tabController,
                  labelPadding: EdgeInsets.symmetric(horizontal: 7.w),
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.unselectedGray,
                  indicator: UnderlineTabIndicator(
                    borderRadius: BorderRadius.circular(17.r),
                    borderSide: BorderSide(
                      color: AppColors.primary,

                      width: 5.w,
                    ),
                  ),
                  indicatorColor: AppColors.blue,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20.sp,
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: AppStrings.summary),
                    Tab(text: AppStrings.ingredients),
                    Tab(text: AppStrings.instructions),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SingleChildScrollView(
                        child: buildSummaryTab(meal: widget.meal),
                      ),
                      SingleChildScrollView(
                        child: buildIngredientsTab(meal: widget.meal),
                      ),
                      SingleChildScrollView(
                        child: buildInstructionsTab(meal: widget.meal),
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
