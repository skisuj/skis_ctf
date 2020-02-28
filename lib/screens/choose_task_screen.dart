import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skis_campus_game/category.dart';
import 'package:skis_campus_game/models/tasklist.dart';
import 'package:skis_campus_game/server_addr.dart';
import 'package:skis_campus_game/themes/mytheme.dart';

import 'package:http/http.dart' as http;
import 'package:skis_campus_game/widgets/task_dialog.dart';

class ChooseTaskScreen extends StatelessWidget{
  final Category category;
  String url = URLaddr.serverAddr + URLaddr.getTasks;

  ChooseTaskScreen({Key key, @required this.category}) : super(key: key);

  Future<TaskList> fetchTasks() async {
    url += this.category.name.toLowerCase();
    print(url);
    final res = await http.get(url);
    if (res.statusCode == 200) {
        return TaskList.fromJson(json.decode(res.body));
    }

    return null;
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder<TaskList>(
        future: fetchTasks(),
        builder: (context, AsyncSnapshot<TaskList> snapshot){
          print("snap:");
          print(snapshot);
          if(snapshot.hasData){
            return Scaffold(
            appBar: AppBar(
              backgroundColor: myTheme.accentColor,
              title: Text(this.category.name),
            ),
            backgroundColor: myTheme.primaryColor,
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: GridView.count(
                  childAspectRatio: 2,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: snapshot.data.tasklist.map((task) => new FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
                    child: Text(task.points.toString()),
                    padding: EdgeInsets.all(20),
                    disabledColor: TaskColors.diasbled,
                    color: task.available ? this.category.color : TaskColors.diasbled,
                    onPressed: task.available ? (){
                      showDialog(context: context, builder: (BuildContext context) => TaskDialog(task: task));
                    } : null,
                  )).toList(),
                 ),
                ),
              )
            );
          }
          else{
            return CircularProgressIndicator();
          }
        },
      );
    }
}