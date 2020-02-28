import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skis_campus_game/screens/category_screen.dart';
import 'package:skis_campus_game/server_addr.dart';
import 'package:skis_campus_game/widgets/teammembers.dart';
import 'package:skis_campus_game/themes/mytheme.dart';
import 'package:skis_campus_game/widgets/teamname.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>{
  bool teamNameEntered = false;
  bool teamExistsInDb = false;
  String teamName;
  List<String> teamMembers;
  var enterTeamName = EnterTeamName();
  var enterTeamMembers = EnterTeamMembers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myTheme.primaryColor,
      body: new Container(
        child: new Center(child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/team.png',
              width: MediaQuery.of(context).size.width * 0.5),
            
            !teamNameEntered ? enterTeamName : enterTeamMembers,

            RaisedButton(
            child: Text('Login'),
            onPressed: () async{

              if(!teamNameEntered && enterTeamName.nameController.text != null){
                //sprawdzic czy druzyna o takiej nazwie juz istnieje!

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("team_name", enterTeamName.nameController.text);
                setState(() {
                  teamNameEntered = true;
                });
              }
              
              else if(teamNameEntered){
                
                /*print(enterTeamName.nameController.text);
                print(enterTeamMembers.memberTextFields[0].memberController.text);
                print(enterTeamMembers.memberTextFields[1].memberController.text);
                print(enterTeamMembers.memberTextFields[2].memberController.text);*/

                List<String> members = [];
                for(int i = 0; i < 3; i++){
                  print(enterTeamMembers.memberTextFields[i].memberController.text);
                  members.add(enterTeamMembers.memberTextFields[i].memberController.text);
                }

                var url = URLaddr.serverAddr + URLaddr.addTeam;
                var body = {
                  "team_name": enterTeamName.nameController.text,
                  "team_members": members
                };

                var bodyEncoded = json.encode(body);
                var res = await http.post(
                  url,
                  body: bodyEncoded,
                  headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                  }
                );

                //jezeli wszystko uzupelnione i druzyna zostala prawidlowo dodana do bazy
                if(res.statusCode == 200){
                  setState(() {
                    teamExistsInDb = true;
                  });
                }
                else{
                  print('error');
                  //blad dodawania do bazy
                }
              }

              if(teamExistsInDb){
                Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (BuildContext context) => CategoryScreen()));
              }
          })
        ],)),
      ),
    );
  }
}