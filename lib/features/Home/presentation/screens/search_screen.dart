import "package:flutter/material.dart";
import "../../../../core/Models/meal_model.dart";
import "../../../../core/Utils/app_colors.dart";
import "../../../../core/Widgets/custom_card.dart";
import "../../../../core/Widgets/custom_field.dart";

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    required this.meals,
    super.key
  });

  final List<Meal> meals;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<Meal> filteredMeals = [];
  final TextEditingController searchController = TextEditingController();

  double currentServingSizeSliderVal = 2;
  double currentCookTimeSliderVal = 20;

  void clearAll(){
    searchController.text = "";
    filteredMeals= [];
  }

  void filterMeals(String input) {
    if(input.isEmpty || input.trim().isEmpty){
      filteredMeals= [];
    }else{
      filteredMeals = widget.meals.where((meal){
        final mealName = meal.title.toLowerCase();
        final inputVal = input.toLowerCase();
        return mealName.startsWith(inputVal);
      }).toList();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("search for your meal"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Hero(
                tag: "search",
                child: Material(
                  child: CustomField(
                    controller: searchController,
                    hint: "Search Recipe",
                    label: "Search Recipe",
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.primary,
                    ),
                    suffixIcon:searchController.text.isNotEmpty ? IconButton(
                      onPressed: () {
                        setState(clearAll);
                      },
                      icon: const Icon(Icons.cancel),
                    ) :null,
                    onChanged: (input){
                      setState((){
                        filterMeals(input);
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: filteredMeals.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        meal: filteredMeals[index],
                        onPressed: (){},
                      );
                    },
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
