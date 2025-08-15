import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:meal_app/features/Home/presentation/screens/home_screen.dart';
import 'package:meal_app/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:meal_app/features/layout/presentation/layout/cubit/layout_states.dart';
import 'package:meal_app/features/layout/presentation/profileTab/screens/profile_screen.dart';

import '../../../../auth/domain/entities/user.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  User currentUser;
  LayoutCubit({
    required this.currentUser
  }):super(LayoutInitial());
  int currentIndex = 0;
  List<Widget> tabs = [HomeScreen(),FavoriteScreen(),ProfileScreen()];


  void changeBottomIndex(int selectedIndex){
    currentIndex = selectedIndex;
    emit(ChangeBottomIndex());
  }

}


