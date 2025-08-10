import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meal_app/features/layout/presentation/favoriteTab/screens/favorite_screen.dart';
import 'package:meal_app/features/layout/presentation/homeTab/screens/home_screen.dart';
import 'package:meal_app/features/layout/presentation/layout/cubit/layout_states.dart';
import 'package:meal_app/features/layout/presentation/profileTab/screens/profile_screen.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit():super(LayoutInitial());
  int currentIndex = 0;
  List<Widget> tabs = [HomeScreen(),FavoriteScreen(),ProfileScreen()];

  void changeBottomIndex(int selectedIndex){
    currentIndex = selectedIndex;
    emit(ChangeBottomIndex());
  }

}