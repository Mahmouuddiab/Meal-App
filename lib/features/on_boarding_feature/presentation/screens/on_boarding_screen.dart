
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/Utils/strings.dart';
import '../../../../core/routing/app_routes.dart';
import '../widgets/on_boarding_four.dart';
import '../widgets/on_boarding_one.dart';
import '../widgets/on_boarding_page_indicator.dart';
import '../widgets/on_boarding_three.dart';
import '../widgets/on_boarding_two.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});


  @override
  State<StatefulWidget> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>{

  int index = 0;
  final PageController _pageViewController = PageController();

@override
void initState() {
  super.initState();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

@override
void dispose() {
  // Restore system default orientations
  SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  _pageViewController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageViewController,
              onPageChanged: (value){
                setState(() {
                  index = value;
                });
              },
              children: [
                OnBoardingOne(),
                OnBoardingTwo(),
                OnBoardingThree(),
                OnBoardingFour(),
              ],
            ),
          ),
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible:index < 3,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: TextButton(
                    child: const Text(AppStrings.skip),
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                      
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OnBoardingPageIndicator(active: index == 0), 
                    const SizedBox(width: 14,),
                    OnBoardingPageIndicator(active: index == 1), 
                    const SizedBox(width: 14,),
                    OnBoardingPageIndicator(active: index == 2), 
                    const SizedBox(width: 14,),
                    OnBoardingPageIndicator(active: index == 3), 
                  ],
                ),
                TextButton(
                  child:Text(index < 3? AppStrings.next : AppStrings.login),
                  onPressed: (){
                    _pageViewController.animateToPage(
                      index+1, 
                      duration: Duration(milliseconds: 250), 
                      curve: Curves.linear
                    );
                  
                    if(index == 3){
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    }
                  
                  
                  },
                    
                ),   
              ],
            ),
          )
        ],
      ),
    );
  }
}