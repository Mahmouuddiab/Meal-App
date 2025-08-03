import 'package:flutter/material.dart';
import 'package:meal_app/core/Utils/app_colors.dart';

class CustomButton extends StatelessWidget {
   void Function()? onPressed;
   Widget? child;
   CustomButton({
     super.key,
     required this.onPressed,
     required this.child
   });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          child: child,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),

        ),
      ),
    );
  }
}
