import 'package:skis_campus_game/category.dart';

class URLaddr {
  static final String serverAddr = "http://ec2-3-8-202-127.eu-west-2.compute.amazonaws.com:3000";

  static final String addTeam = "/team/create";
  static final String cancelTask = "/task/abort";
  static final String getTasks = "/task/list/";
  static final String beginTask = "/task/begin";
}