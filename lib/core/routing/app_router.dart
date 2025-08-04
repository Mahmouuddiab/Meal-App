import 'package:flutter/material.dart';
import 'package:meal_app/features/auth/presentation/screens/login_screen.dart';
import 'package:meal_app/features/auth/presentation/screens/register.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const Register());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text("Not Found"))),
        );
    }
  }
}
