import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/core/locator/service_locator.dart';
import 'package:meal_app/core/routing/app_router.dart';
import 'package:meal_app/core/routing/app_routes.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meal_app/features/auth/presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependices();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
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
      child: MaterialApp(
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
