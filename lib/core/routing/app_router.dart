import 'package:flutter/material.dart';
import 'package:meal_app/features/auth/presentation/screens/login_screen.dart';
import 'package:meal_app/features/auth/presentation/screens/register.dart';
import 'package:meal_app/features/on_boarding_feature/presentation/screens/SplahScreen.dart';
import 'package:meal_app/features/on_boarding_feature/presentation/screens/on_boarding_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const Register());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(body: Center(child: Text("Not Found"))),
        );
    }
  }
}
