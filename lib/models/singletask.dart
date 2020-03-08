import 'package:skis_campus_game/category.dart';

class SingleTask{
  final String name;
  final String description;
  final int points;
  bool available;
  final Category category;

  SingleTask({
    this.name, 
    this.description,
    this.points,
    this.available,
    this.category
  });

  factory SingleTask.fromJson(Map<String, dynamic> json){
    return new SingleTask(
      name: json['name'],
      description: json['description'],
      points: json['points'],
      available: json['available'],
      category: categories[json['category']]
    );
  }
}