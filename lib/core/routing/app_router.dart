import 'package:flutter/material.dart';
import 'package:meal_app/core/locator/service_locator.dart';
import 'package:meal_app/features/layout/presentation/layout/cubit/layout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/Models/meal_model.dart';
import 'package:meal_app/features/Home/presentation/screens/meal_details_screen.dart';
import 'package:meal_app/features/auth/presentation/screens/login_screen.dart';
import 'package:meal_app/features/auth/presentation/screens/register.dart';
import 'package:meal_app/features/gemini/Domain/UseCase/getRecipeSuggestionUseCase.dart';
import 'package:meal_app/features/gemini/data/dataSource/recipe_remote_data_source.dart';
import 'package:meal_app/features/gemini/data/repository/recipe_repository.dart';
import 'package:meal_app/features/gemini/presentation/Screens/gemini_screen.dart';
import 'package:meal_app/features/gemini/presentation/cubit/suggested_recipe_cubit.dart';
import 'package:meal_app/features/layout/presentation/layout/screens/layout_screen.dart';
import 'package:meal_app/features/on_boarding_feature/presentation/screens/SplahScreen.dart';
import 'package:meal_app/features/on_boarding_feature/presentation/screens/on_boarding_screen.dart';
import '../../features/auth/domain/entities/user.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.geminiScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SuggestedRecipeCubit>(
                create: (_) => SuggestedRecipeCubit(GetRecipeSuggestionUseCase(
                    RecipeRepository(RecipeRemoteDatasource()))),
                child: MealSuggestionScreen()));
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const Register());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case AppRoutes.layout:
        final user = settings.arguments as User;
        serviceLocator.registerLazySingleton<LayoutCubit>(
          ()=> LayoutCubit(currentUser: user)
        );
        return MaterialPageRoute(builder: (_) => LayoutScreen());
      case AppRoutes.mealDetails:
        return MaterialPageRoute(
          builder: (_) => MealDetailsScreen(meal: settings.arguments as Meal,),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(body: Center(child: Text("Not Found"))),
        );
    }
  }
}
