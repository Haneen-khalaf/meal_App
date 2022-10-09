import 'package:flutter/material.dart';
import 'package:mealapp/providers/languageProvider.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/screens/filters_screen.dart';
import 'package:mealapp/screens/tabs_screen.dart';

import '../screens/theme_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(String title,IconData icon,Function() taphandlar,BuildContext ctx){
    return ListTile(
      leading: Icon(icon,size: 26,color: Theme.of(ctx).splashColor,),
      title: Text(title,style: TextStyle(fontSize: 24,
          color: Theme.of(ctx).textTheme.bodyText1!.color,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold
      ),),
      onTap: taphandlar,
    );
  }
  @override
  Widget build(BuildContext context) {
    var lan=Provider.of<LanguageProvider>(context,listen: true);

    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children:[
            Container(
              color: Theme.of(context).colorScheme.secondary,
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: lan.isEn
               ?Alignment.centerLeft
               :Alignment.centerRight,
              child: Text(
                lan.getTexts("drawer_name").toString(),
                style: TextStyle(fontSize: 30,
                  fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.primary
                ),),
            ),
            SizedBox(height: 20,),
            buildListTile(lan.getTexts('drawer_item1').toString(), Icons.restaurant,(){Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);},context,),
            buildListTile(lan.getTexts('drawer_item2').toString(), Icons.settings,(){Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);},context),
            buildListTile(lan.getTexts('drawer_item3').toString(), Icons.color_lens,(){Navigator.of(context).pushReplacementNamed(ThemesScreen.routeName);},context),
            Divider(height: 10,color: Colors.black45,),
            Padding(
              padding: const EdgeInsets.only(right: 8.0,left: 8),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20,right: 22),
                child: Text(lan.getTexts('drawer_switch_title').toString(),style: Theme.of(context).textTheme.headline6,),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(lan.getTexts('drawer_switch_item2').toString(),style: Theme.of(context).textTheme.headline6,),
                  Switch(
                      value: Provider.of<LanguageProvider>(context,listen: true).isEn,
                      onChanged: (newValue){
                        Provider.of<LanguageProvider>(context,listen: false).changeLan(newValue);
                        Navigator.of(context).pop();
                      },
                  inactiveTrackColor: Provider.of<ThemeProvider>(context,listen: true).tm==ThemeMode.light?null:Colors.black,
                  ),
                  Text(lan.getTexts('drawer_switch_item1').toString(),style: Theme.of(context).textTheme.headline6,)
                ],
              ),
            ),
            Divider(
              height: 10,color: Colors.black45,
            )
          ]
        ),
      ),
    );
  }
}
