import 'package:flutter/material.dart';

class OnBoardingPageIndicator extends StatelessWidget{

  final bool active;
  const OnBoardingPageIndicator({required this.active , super.key});

  
  @override
  Widget build(BuildContext context){
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: 10,
      width: 30,
      decoration: BoxDecoration(
        color:active ? Color.fromRGBO(0, 26, 63, 1) :  Colors.grey,
        borderRadius: BorderRadius.circular(100)
      ),
      
    );
  }

}