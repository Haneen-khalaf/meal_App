import 'package:flutter/material.dart';
import 'package:mealapp/dummydata.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:mealapp/widget/category_item.dart';
import 'package:provider/provider.dart';

import '../providers/languageProvider.dart';
class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var lan=Provider.of<LanguageProvider>(context,listen: true);

    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        body: GridView(
          padding: EdgeInsets.all(25),
            children: Provider.of<MealProvider>(context).availableCategory
                .map((catData) =>
                CategoryItem(catData.id, catData.color),
            ).toList(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 120,
              maxCrossAxisExtent: 200,
              childAspectRatio: 3/2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
        ),
      ),
    );
  }
}
