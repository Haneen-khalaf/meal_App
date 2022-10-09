import 'package:flutter/material.dart';

import '../dummydata.dart';
import 'package:provider/provider.dart';

import '../providers/languageProvider.dart';
import '../providers/meal_provider.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName='meal_detail';

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildSectionTitle(String text,BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text,style: Theme.of(context).textTheme.headline6,textAlign: TextAlign.center,),
    );
  }

 Widget buildContainer(Widget child,BuildContext context){
   bool isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
   var dw=MediaQuery.of(context).size.width;
   var dh=MediaQuery.of(context).size.height;
   return Container(
     decoration: BoxDecoration(
         color: Colors.white70,
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(10)
     ),
     margin: EdgeInsets.all(10),
     padding: EdgeInsets.all(10),
     height: isLandscape?dh*0.5:dh*0.25,
     width: isLandscape?(dw*0.5-30):dw,
     child: child,
   );
 }

 String mealId='';

  @override
  void didChangeDependencies() {
    mealId=ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    var dw=MediaQuery.of(context).size.width;
    final mealId=ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal=DUMMY_MEALS.firstWhere((meal) => meal.id==mealId);
    var lan=Provider.of<LanguageProvider>(context,listen: true);

    List<String> stepsLi=lan.getTexts('steps-$mealId') as List<String>;
    var listeps=ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder:(ctx,index) =>Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('# ${index+1}'),
            ),
            title: Text(stepsLi[index],
              style: TextStyle(color: Colors.black
              ),),
          ),
          Divider(),
        ],
      ),
      itemCount: stepsLi.length,
    );
   List<String> liIngredientLi= lan.getTexts('ingredients-$mealId')as List<String>;
    var liIngredients=ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder:(ctx,index) =>Card(
        color:Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
          child: Text(liIngredientLi[index],
            //style: TextStyle(color: Colors.black),
            ),
        ),
      ),
      itemCount: liIngredientLi.length,
    );

    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(lan.getTexts('meal-$mealId').toString()),
                background: Hero(
                    tag: mealId,
                    child: InteractiveViewer(
                        child: FadeInImage(
                            placeholder: AssetImage('assets/images/a2.png'),
                            image: NetworkImage(selectedMeal.imageUrl,
                            ),fit:BoxFit.cover)
                    )
                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              if(isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      buildSectionTitle(lan.getTexts('Ingredients').toString(), context),
                      buildContainer(liIngredients,context),
                    ],
                  ),
                  Column(
                    children: [
                      buildSectionTitle(lan.getTexts('Steps').toString(), context),
                      buildContainer(listeps,context),
                    ],
                  )
                ],
              ),
              if(!isLandscape) buildSectionTitle(lan.getTexts('Ingredients').toString(), context),
              if(!isLandscape) buildContainer(liIngredients,context),
              if(!isLandscape) buildSectionTitle(lan.getTexts('Steps').toString(), context),
              if(!isLandscape) buildContainer(listeps,context),
            ])),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
              Provider.of<MealProvider>(context,listen: true).isFavorite(mealId)
                  ? Icons.star
                  : Icons.star_border),
          onPressed: ()=>Provider.of<MealProvider>(context,listen: false).toggleFavorite(mealId),
        )
      ),
    );
  }
}
