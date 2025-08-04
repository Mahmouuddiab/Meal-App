import 'package:flutter/material.dart';

import '../../../../core/Utils/app_colors.dart';
import '../../../../core/Utils/app_images.dart';

class OnBoardingImageContainer extends StatelessWidget {

  final int imageNumber;
  const OnBoardingImageContainer({required this.imageNumber , super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.black,
          width: 1.5,  // Lightweight border
        ),
      ),
      padding: EdgeInsets.all(23),  // Space between border and image
      child: ClipOval(
        child: SizedBox(
          height: 238,
          width: 238,
          child: Image.asset(
            imageNumber == 1 ? AppImages.onboarding1 : AppImages.onboarding2 ,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  
}