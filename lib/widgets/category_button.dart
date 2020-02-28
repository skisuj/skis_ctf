import 'package:flutter/material.dart';
import 'package:skis_campus_game/category.dart';
import 'package:skis_campus_game/screens/choose_task_screen.dart';

class CategoryButton extends StatelessWidget{
  final Category category;

  const CategoryButton({Key key, @required this.category}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Material(
      color: category.color,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseTaskScreen(category: category)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Image.asset(
            category.imgName,
            width: 100.0,
            height: 100.0,),
          Text(category.name)
        ],)
      ),
    );
  }
}