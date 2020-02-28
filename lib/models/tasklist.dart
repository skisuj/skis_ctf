import 'package:skis_campus_game/models/singletask.dart';

class TaskList{
  final List<SingleTask> tasklist;

  TaskList({
    this.tasklist
  });

  factory TaskList.fromJson(Map<String, dynamic> json){
    var items = json["Items"];
    List<SingleTask> tasklist = List<SingleTask>.from(items.map((i) => SingleTask.fromJson(i)));

    return new TaskList(
      tasklist: tasklist
    );
  }
}