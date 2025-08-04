import 'package:flutter/material.dart';
import 'logo_circle_avatar.dart';
import 'on_boarding_image_container.dart';
import 'on_boarding_text.dart';
import 'u_shaped_container.dart';

class OnBoardingTwo extends StatelessWidget{
  const OnBoardingTwo({super.key});


  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            UShapedContainer(),
            Positioned(
              top: 120,
              child: LogoCircleAvatar()
            ),
            Positioned(
              bottom: -20,
              child: OnBoardingImageContainer(imageNumber: 2,)
            ),
          ],
        ),
        SizedBox(
          height: 36,
        ),
        OnBoardingText(),
      ],
    );
  }
}