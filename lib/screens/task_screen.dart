import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:skis_campus_game/models/singletask.dart';
import 'package:skis_campus_game/server_addr.dart';
import 'package:skis_campus_game/themes/mytheme.dart';

class TaskScreen extends StatefulWidget{
  final SingleTask task;

  const TaskScreen({Key key, @required this.task}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TaskScreenState();
  }
}

class _TaskScreenState extends State<TaskScreen>{
  String qrCode = "";

  Future scanQR() async{
    try{
        String qr = await BarcodeScanner.scan();
        setState(() {
          this.qrCode = qr;
        });
    }
    on PlatformException catch(e){
      if(e.code == BarcodeScanner.CameraAccessDenied){
        setState(() => this.qrCode = "Camera permission not granted");
      }
      else{
        setState(() => this.qrCode = "Unknown error");
      }
    }
    on FormatException{
      setState(() => this.qrCode = "null");
    }
    catch(e){
      setState(() => this.qrCode = "Unknown error");
    }
  }

  Future<bool>_onWillPop(){
    return showDialog(context: context, 
      builder: (context) => new AlertDialog(
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              var url = URLaddr.serverAddr + URLaddr.cancelTask;
              var body = {
                "name": widget.task.name,
                "category": widget.task.category.name.toLowerCase()
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

              if(res.statusCode == 200){
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              }
              else{

              }
              
              //replace with named route!!!!!!!
            },
            child: Text("YES"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("NOPE"),
          ),
        ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
      appBar: AppBar(backgroundColor: myTheme.accentColor, title: Text(widget.task.name),),
      body: Container(
        color: myTheme.primaryColor,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/categories/tmp/resistor.png', height: 100), 
              color: widget.task.category.color
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text(widget.task.description, style: TextStyle(fontSize: 16),),
                  TextField(),
                  MaterialButton(
                    onPressed: scanQR,
                    shape: CircleBorder(),
                    color: widget.task.category.color,
                    child: Icon(Icons.camera_alt),
                    padding: EdgeInsets.all(10),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: widget.task.category.color,
        child: Icon(Icons.check),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.red, 
        notchMargin: 4,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), title: Text("Scan QR")),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), title: Text("Answer")),
          //BottomNavigationBarItem(icon: Icon(Icons.check), title: Text("Submit")),
        ],)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/

      
    ));
  }
}

/*RaisedButton(
              child: Text("Scan QR"),
              onPressed: scanQR,
            ),
            RaisedButton(
              //child: Text
              onPressed: (){},
            ),
            RaisedButton(
              child: Text("Submit"),
              onPressed: () {},) */