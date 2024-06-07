import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/screens/categories.dart';
import 'package:mealsapp/screens/filters.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

const kInitialFilters = {
    Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegetarian:false,
    Filter.vegan:false
};

class TabScreen extends StatefulWidget{
  const TabScreen({
    super.key,

  });


  @override
  State<TabScreen> createState() {
   return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen>{
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeal = [];
  Map<Filter , bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content : Text(message),
      ),
    );
  }

  void _toggleMealFavouritesScreen(Meal meal){
    final isExisting = _favouriteMeal.contains(meal);
  

  if (isExisting){
    setState(() {
      _favouriteMeal.remove(meal);
    });
    _showInfoMessage('Meal is no longer a favourite. ');
    
  }
  else{
   setState(() {
      _favouriteMeal.add(meal);
   });
   _showInfoMessage('Marked as favourite !');
  }
}
 
  
  void _selecPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async{
    Navigator.of(context).pop();
    if(identifier == 'filters'){
      final result = await Navigator.of(context).push<Map<Filter , bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(currentFilters: _selectedFilters,), 
        ),
      );

    setState(() {
      _selectedFilters = result ?? kInitialFilters;
    });
  }
}
  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal){
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter. vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }
    ).toList();

    Widget activePage =  CategoriesScreen(
      onToggleFavourite : _toggleMealFavouritesScreen,
      availableMeals: availableMeals,
    
    );
     var activePageTitle = 'Categories';

    if(_selectedPageIndex == 1){
      activePage = MealsScreen(
        meals: _favouriteMeal , 
        onToggleFavourite:_toggleMealFavouritesScreen
      );
       activePageTitle = 'Your Favourites';

    }

    return Scaffold(
      appBar: AppBar(
        title : Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body:activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap:_selecPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label :'Categories',),
          BottomNavigationBarItem(icon: Icon(Icons.star), label :'Favourites',),

        ],
      ),
    );
  }
}