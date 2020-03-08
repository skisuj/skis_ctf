import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:skis_campus_game/category.dart';
import 'package:skis_campus_game/models/sockets/cat_socket.dart';
import 'package:skis_campus_game/models/tasklist.dart';
import 'package:skis_campus_game/server_addr.dart';
import 'package:skis_campus_game/themes/mytheme.dart';
import 'package:skis_campus_game/widgets/task_dialog.dart';
import 'package:http/http.dart' as http;

class ChooseTaskScreen extends StatefulWidget{
  final Category category;

  ChooseTaskScreen({Key key, @required this.category}) : super(key: key);

  @override
  _ChooseTaskScreenState createState() => _ChooseTaskScreenState();
}

class _ChooseTaskScreenState extends State<ChooseTaskScreen> {
  //CatSocket socket;
  TaskList tasks;

  @override
  void initState(){
    super.initState();
    //socket = CatSocket(this.callback);
  }

  void callback(String name, bool av){
    setState(() {
      tasks.tasklist.firstWhere((item) => item.name == name).available = av;
    });
  }

  Future<TaskList> fetchTasks() async {
    String url = URLaddr.serverAddr + URLaddr.getTasks + this.widget.category.name.toLowerCase();
    print(url);
    final res = await http.get(url);
    if (res.statusCode == 200) {
      if(mounted)
      {
        setState(() {
          tasks = TaskList.fromJson(json.decode(res.body));
        });
      }
      return tasks;
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
              title: Text(this.widget.category.name),
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
                  children: tasks.tasklist.map((task) => new FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
                    child: Text(task.points.toString()),
                    padding: EdgeInsets.all(20),
                    disabledColor: TaskColors.diasbled,
                    color: task.available ? this.widget.category.color : TaskColors.diasbled,
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