import 'package:flutter/material.dart';
import 'package:skis_campus_game/themes/mytheme.dart';
import 'package:skis_campus_game/widgets/category_button.dart';
import 'package:skis_campus_game/category.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myTheme.primaryColor,
      appBar: AppBar(title: Text('Categories'), backgroundColor: myTheme.accentColor),
      body:
      GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        padding: EdgeInsets.all(20),
        children: categories.entries.map((item) => new CategoryButton(category: item.value)).toList(),
      )
    );
  }
}