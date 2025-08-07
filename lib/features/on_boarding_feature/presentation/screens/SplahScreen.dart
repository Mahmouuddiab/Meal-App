// ignore_for_file: use_full_hex_values_for_flutter_colors, use_build_context_synchronously, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/app_images.dart';
import 'package:meal_app/core/routing/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override

  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.register);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: Image.asset(AppImages.CookerLogo),
        ),
      ),
    );
  }
}
