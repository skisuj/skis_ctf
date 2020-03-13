import 'package:skis_campus_game/category.dart';

class SingleTask{
  final String name;
  final String description;
  final String answer;
  final String path;
  final int points;
  bool available;
  final Category category;
  

  SingleTask({
    this.name, 
    this.description,
    this.answer,
    this.path,
    this.points,
    this.available,
    this.category,
  });

  factory SingleTask.fromJson(Map<String, dynamic> json, Category cat){
    return new SingleTask(
      name: json['name'],
      description: json['description'],
      answer: json['answer'],
      path: json['path'],
      points: json['points'],
      available: json['available'],
      category: cat,
    );
  }
}