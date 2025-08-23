import 'package:flutter/material.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/features/gemini/data/dataSource/recipe_remote_data_source.dart';
import 'package:meal_app/features/gemini/presentation/widgets/ingredients_list.dart';
import 'package:meal_app/features/gemini/presentation/widgets/instructions_list.dart';
import '../Screens/gemini_screen.dart';
import '../cubit/suggested_recipe_state.dart';
import 'card_content.dart';

class RecipeDetails extends StatelessWidget {
  final SuggestedRecipeSuccess state;

  const RecipeDetails({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final recipe = state.suggestedRecipe;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const SectionHeader(title: 'Meal Name'),
        CardContent(content: recipe.name),
        const SizedBox(height: 10),
        const SectionHeader(title: 'Description'),
        CardContent(content: recipe.summary),
        const SizedBox(height: 10),
        const SectionHeader(title: 'Ingredients'),
        IngredientList(ingredients: recipe.ingredients),
        const SizedBox(height: 10),
        const SectionHeader(title: 'Instructions'),
        InstructionList(instructions: recipe.mealSteps),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              try {
                final mealDatasource = RecipeRemoteDatasource();
                await mealDatasource.saveMeal(
                  recipe,
                ); 
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Meal added to Home!")),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Failed to save meal: $e")),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              'Add to Home',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
