import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/screens/meal_details.dart';
import 'package:mealsapp/widgets/meals_item.dart';

class MealsScreen extends StatelessWidget{

  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavourite,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourite;

  void selectMeal(BuildContext context, Meal meal){
    // Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavourite :onToggleFavourite,
          
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Uh Oh....nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,

              ),
            ),
            const SizedBox(height :16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,

              ),
            ),
        ]),
      );
      
      if(meals.isNotEmpty){
        content = ListView.builder(
          itemCount: meals.length,

          itemBuilder: (ctx , index) => MealItem(
            meal: meals[index] ,
             onSelectMeal: (meal) {
              selectMeal(context, meal);

          },
        ),
        );
      }

    if(title == null){
      return content;
    }

    return  Scaffold(
      appBar: AppBar(
        title:Text(title!),
      ),
      body : content,
    );
  }
}