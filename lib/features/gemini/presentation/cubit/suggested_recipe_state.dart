import 'package:meal_app/features/gemini/data/models/ai_meal_model.dart';
import 'package:meal_app/features/gemini/data/models/image_model.dart';

abstract class SuggestedRecipeState {}

class SuggestedRecipeInitial extends SuggestedRecipeState {}

class SuggestedRecipeSuccess extends SuggestedRecipeState {
  final AIMeal suggestedRecipe;
  final ImageModel dishImage;
  SuggestedRecipeSuccess(this.suggestedRecipe,this.dishImage);
}

class SuggestedRecipeLoading extends SuggestedRecipeState {}

class SuggestedRecipeError extends SuggestedRecipeState {
  final String errorMessage;

  SuggestedRecipeError({required this.errorMessage});
}
