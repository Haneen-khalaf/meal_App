import 'package:flutter/material.dart';
import 'package:mealapp/providers/theme_provider.dart';

import '../providers/languageProvider.dart';
import '../providers/meal_provider.dart';
import '../widget/main_drawer.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName='/filters';

  final bool fromOnBoarding;

  FiltersScreen({this.fromOnBoarding=false});

  @override
  Widget build(BuildContext context) {
    final Map<String,bool> currentFilters=Provider.of<MealProvider>(context,listen: true).filters;

    var lan=Provider.of<LanguageProvider>(context,listen: true);

  return Directionality(
    textDirection:lan.isEn?TextDirection.ltr:TextDirection.rtl,
    child: Scaffold(
     appBar: fromOnBoarding ?AppBar(backgroundColor: Theme.of(context).canvasColor,elevation: 0,)
      :AppBar(title: Text(lan.getTexts('filters_appBar_title').toString())),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(lan.getTexts('filters_screen_title').toString(),style: Theme.of(context).textTheme.headline6,),
            ),

            Expanded(

              child: ListView(
                children: [
                  SwitchListTile(
                      inactiveTrackColor:Provider.of<ThemeProvider>(context,listen: true).tm==ThemeMode.light?null:Colors.black,
                      title:Text(lan.getTexts('Gluten-free').toString()),
                      value: currentFilters['gluten']!,
                      subtitle: Text(lan.getTexts('Gluten-free-sub').toString()),
                      onChanged: (newValue){
                          currentFilters['gluten']=newValue;

                        Provider.of<MealProvider>(context,listen: false).setFilters();
                      }),
                  SwitchListTile(
                      inactiveTrackColor:Provider.of<ThemeProvider>(context,listen: true).tm==ThemeMode.light?null:Colors.black,
                      title:Text(lan.getTexts('Lactose-free').toString()),
                      value: currentFilters['lactose']!,
                      subtitle: Text(lan.getTexts('Lactose-free_sub').toString()),
                      onChanged: (newValue){
                          currentFilters['lactose']=newValue;

                        Provider.of<MealProvider>(context,listen: false).setFilters();
                      }),
                  SwitchListTile(
                      inactiveTrackColor:Provider.of<ThemeProvider>(context,listen: true).tm==ThemeMode.light?null:Colors.black,
                      title:Text(lan.getTexts('Vegetarian').toString()),
                      value:  currentFilters['vegetarian']!,
                      subtitle: Text(lan.getTexts('Vegetarian-sub').toString()),
                      onChanged: (newValue){

                          currentFilters['vegetarian'] =newValue;

                        Provider.of<MealProvider>(context,listen: false).setFilters();
                      }),
                  SwitchListTile(
                      inactiveTrackColor:Provider.of<ThemeProvider>(context,listen: true).tm==ThemeMode.light?null:Colors.black,
                      title:Text(lan.getTexts('Vegan').toString()),
                      value:  currentFilters['vegan']!,
                      subtitle: Text(lan.getTexts('Vegan-sub').toString()),
                      onChanged: (newValue){
                          currentFilters['vegan'] =newValue;

                        Provider.of<MealProvider>(context,listen: false).setFilters();
                      }),
                ],

              ),

            ),


          ],


        ),


        drawer: MainDrawer(),
      ),
  );
  }

  // SwitchListTile buildSwitchListTile(String title,String description, bool currentValue,Function updateValue) {
  //   return SwitchListTile(
  //                 title:Text(title),
  //                   value: currentValue,
  //                   subtitle: Text(description),
  //                   onChanged: updateValue(),
  //
  //               );

}
