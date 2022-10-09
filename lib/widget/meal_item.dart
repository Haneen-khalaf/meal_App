import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../providers/languageProvider.dart';
import '../screens/meal_detail_screen.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.id,
  });

  void selectMeal(BuildContext ctx){
     Navigator.of(ctx).pushNamed(MealDetailScreen.routeName,
       arguments: id,
     ).then((result) {
      // if (result != null) removeItem(result);

     });
  }

  @override
  Widget build(BuildContext context) {
    var lan=Provider.of<LanguageProvider>(context,listen: true);
    // Directionality(
    //   textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl
    return InkWell(
        onTap:()=> selectMeal(context),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15) ),
                    child: Hero(
                        tag: id,
                    child: InteractiveViewer(
                            child: FadeInImage(
                                placeholder: AssetImage('assets/images/a2.png'),
                                image: NetworkImage(imageUrl,),fit:BoxFit.cover,width: double.infinity,height: 200,)
                        )
                    ),
                    ),
                  Positioned(
                    bottom: 20,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                        color: Colors.black54,
                        width: 300,
                        child: Text(
                            lan.getTexts('meal-$id').toString(),
                            style: TextStyle(fontSize: 26,color: Colors.white),softWrap: true,overflow: TextOverflow.fade),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule,color: Theme.of(context).splashColor,),
                        SizedBox(width: 6,),
                        if(duration<=10)
                          Text('$duration '+lan.getTexts('min2').toString()),
                        if(duration>10)
                          Text('$duration '+lan.getTexts('min').toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.work,color: Theme.of(context).splashColor,),
                        SizedBox(width: 6,),
                        Text(lan.getTexts('$complexity').toString(),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money,color: Theme.of(context).splashColor,),
                        SizedBox(width: 6,),
                        Text(lan.getTexts('$affordability').toString(),),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),

    );
  }
}
