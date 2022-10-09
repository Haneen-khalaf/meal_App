import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../providers/languageProvider.dart';
import '../providers/meal_provider.dart';
import '../widget/meal_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var lan=Provider.of<LanguageProvider>(context,listen: true);
    bool isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    var dw=MediaQuery.of(context).size.width;

    final List<Meal> favoriteMeals=Provider.of<MealProvider>(context,listen: true).favoriteMeals;

    if(favoriteMeals.isEmpty){
      return Center(
        child: Text(lan.getTexts('favorites_text').toString(),style: TextStyle(color: Colors.black),),
      );
    }
    else{
      return GridView.builder(
        itemBuilder:(ctx,index){
          return MealItem(
            id: favoriteMeals[index].id,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
            affordability: favoriteMeals[index].affordability,
          );
        } ,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // mainAxisExtent: 120,
          maxCrossAxisExtent:dw<=400?400:500,
          childAspectRatio:isLandscape? dw/(dw*0.8):dw/(dw*0.75),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: favoriteMeals.length,
      );
    }
  }
}
