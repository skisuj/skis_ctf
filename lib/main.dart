import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skis_campus_game/themes/mytheme.dart';
import 'package:skis_campus_game/screens/category_screen.dart';
import 'package:skis_campus_game/screens/login_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var teamName = prefs.getString('team_name');
  print(teamName);
  runApp(
    MaterialApp(
      theme: myTheme,
      home: teamName == null ? 
      LoginScreen() : CategoryScreen())
  );
}
    

    
//https://stackoverflow.com/questions/54377188/how-to-use-shared-preferences-to-keep-user-logged-in-flutter