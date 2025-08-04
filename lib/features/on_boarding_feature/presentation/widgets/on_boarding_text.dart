

import 'package:flutter/material.dart';

class OnBoardingText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "like in a Restaurant but at home ,",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17
          ),
        ),
        SizedBox(height:16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:26),
          child: Text(
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700
            ),
            textAlign: TextAlign.center,
            "consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea qui officia deserunt mollit anim id est laborum."
          ),
        ),
      ],
    );
  }

}