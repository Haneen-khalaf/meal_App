import 'package:flutter/material.dart';

import '../providers/languageProvider.dart';
import '../screens/category_meal_screen.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final Color color;

  const CategoryItem(this.id,  this.color) ;

  void selectCategory(BuildContext ctx){
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName,
    arguments: {
      'id':id,
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    var lan=Provider.of<LanguageProvider>(context,listen: true);

    return InkWell(
      onTap: ()=> selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text((lan.getTexts('cat-$id')).toString(),style: Theme.of(context).textTheme.headline6,),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:[
              color.withOpacity(0.4),
              color
            ] ,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
          borderRadius: BorderRadius.circular(15),

        ),

      ),
    );
  }
}
