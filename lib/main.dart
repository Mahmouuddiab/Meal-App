import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/Utils/app_theme.dart';
import 'package:meal_app/core/locator/service_locator.dart';
import 'package:meal_app/core/routing/app_router.dart';
import 'package:meal_app/core/routing/app_routes.dart';
import 'package:meal_app/features/Home/presentation/Cubit/home_cubit.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meal_app/features/favorites/presentation/cubit/favorites_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependices();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (context) => serviceLocator<HomeCubit>()),
        BlocProvider(create: (context) => serviceLocator<FavoritesCubit>()),
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
          theme: AppTheme.lightTheme,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.generateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
