import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/locator/service_locator.dart';
import 'package:meal_app/core/routing/app_router.dart';
import 'package:meal_app/core/routing/app_routes.dart';
import 'package:meal_app/features/Home/presentation/Cubit/home_cubit.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependices();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
        
        // it should be wrapped around the home tab widget 
        BlocProvider(create: (context) => serviceLocator<HomeCubit>()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: AppColors.primary
              )
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedIconTheme: IconThemeData(
                color: AppColors.white,
                size: 30
              ),
              unselectedIconTheme: IconThemeData(
                color: AppColors.primary,
                size: 30
              ),
            )
          ),
          initialRoute:AppRoutes.splash,
          onGenerateRoute: AppRouter.generateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
