import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/category_grid_item.dart';
import 'package:mealsapp/models/category.dart';

class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({super.key , required this.onToggleFavourite, required this.availableMeals});

  final void Function(Meal meal) onToggleFavourite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category){
    final filtereMeals = availableMeals
    .where((meal) => meal.categories.contains(category.id))
    .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title, 
          meals: filtereMeals,
          onToggleFavourite :onToggleFavourite,
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
       GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2 ,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ) ,
        children: [
          //availableCategories.map((category) => CategoryGridItem(category:category)).toList()
          for(final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: (){
              _selectCategory(context , category);
            },
          )
        ],
      );
    
  }
}