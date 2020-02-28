import 'package:flutter/material.dart';

class MemberTextField extends StatelessWidget{
  final memberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: memberController,
      decoration: InputDecoration(
      hintText: 'Member name:',
      isDense: true, 
      contentPadding: EdgeInsets.all(10),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
          )
      )
    );
  }
}