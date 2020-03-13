import 'package:skis_campus_game/category.dart';
import 'package:skis_campus_game/models/singletask.dart';

class TaskList{
  final List<SingleTask> tasklist;

  TaskList({
    this.tasklist
  });

  factory TaskList.fromJson(List<dynamic> items, Category category){
    List<SingleTask> tasklist = List<SingleTask>.from(items.map((i) => SingleTask.fromJson(i, category)));

    return new TaskList(
      tasklist: tasklist
    );
  }
}