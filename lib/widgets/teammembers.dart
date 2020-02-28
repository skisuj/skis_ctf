import 'package:flutter/material.dart';
import 'package:skis_campus_game/widgets/member_text_field.dart';


class EnterTeamMembers extends StatelessWidget{
  final List<MemberTextField> memberTextFields = [MemberTextField(), MemberTextField(), MemberTextField()];
  //final membersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Text('Enter team members', style: Theme.of(context).textTheme.title,),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(children: memberTextFields),  
        )
      ]);
  }
}