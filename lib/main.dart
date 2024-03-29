import 'package:flutter/material.dart';
import 'package:mealapp/providers/languageProvider.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/screens/category_meal_screen.dart';
import 'package:mealapp/screens/filters_screen.dart';
import 'package:mealapp/screens/meal_detail_screen.dart';
import 'package:mealapp/screens/on_boarding_screen.dart';
import 'package:mealapp/screens/tabs_screen.dart';
import 'package:mealapp/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs=await SharedPreferences.getInstance();

  Widget homeScreen=(prefs.getBool('watched')??false)?TabsScreen():OnBoardingScreen();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<MealProvider>(
        create: (ctx) =>MealProvider(),
      ),
      ChangeNotifierProvider<ThemeProvider>(
          create:(ctx)=>ThemeProvider()
      ),
      ChangeNotifierProvider<LanguageProvider>(
          create:(ctx)=>LanguageProvider()
      ),
    ],
      child: MyApp(homeScreen),
    ),
  );
}

class MyApp extends StatelessWidget {

  final Widget mainScreen;

  const MyApp(this.mainScreen);


  @override
  Widget build(BuildContext context) {
    var primaryColor=Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor=Provider.of<ThemeProvider>(context,listen: true).accentColor;
    var tm=Provider.of<ThemeProvider>(context,listen: true).tm;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode:tm,
      theme: ThemeData(
          primarySwatch: primaryColor,
          colorScheme:ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor),
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          splashColor: Colors.black87,
          cardColor: Colors.white,
          shadowColor: Colors.white60,
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),

              headline6: TextStyle(
                  color:Colors.black87,
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold
              ),
            headline5: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color:Colors.black87
          ),
            headline4: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                fontSize: 40,
              color:Colors.black87,
            ),

          )
      ),
      darkTheme: ThemeData(
        primarySwatch: primaryColor,
        colorScheme:ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor),
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        fontFamily: 'Raleway',
          splashColor: Colors.white70,
        cardColor: Color.fromRGBO(24, 37, 51, 1),
        shadowColor: Colors.black54,
        unselectedWidgetColor: Colors.white70,
        textTheme: ThemeData.dark().textTheme.copyWith(
          bodyText1: TextStyle(
          color: Colors.white,
          ),

          headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline5: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            color: Colors.white,
          ),
          headline4: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              fontSize: 40,
            color: Colors.white,
          ),
        )
      ),
      routes: {
        '/':(context)=>mainScreen,
        TabsScreen.routeName:(context)=>TabsScreen(),
        CategoryMealsScreen.routeName:(context)=>CategoryMealsScreen(),
        MealDetailScreen.routeName:(context)=>MealDetailScreen(),
        FiltersScreen.routeName:(context)=>FiltersScreen(),
        ThemesScreen.routeName:(context)=>ThemesScreen(),
      },

    );
  }
}

