import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  Future _scanQR() async{
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

  bool _verifyAnswer(){
    return true;
  }

  Future<bool>_onWillPop(){
    return showDialog(context: context, 
      builder: (context) => new AlertDialog(
        content: new Text('Do you want to abort this task?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("No"),
          ),
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
            },
            child: Text("Yes"),
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
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: CachedNetworkImage(
                imageUrl: URLaddr.s3path + widget.task.path,
              ),
              padding: EdgeInsets.all(15),
              ),
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 52,
        margin: EdgeInsets.all(0),
        child: RaisedButton(
          onPressed: _verifyAnswer,
          color: widget.task.category.color,
          child: Text("SUBMIT"),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQR,
        backgroundColor: widget.task.category.color,
        child: Image.asset('assets/images/qr_code.png', height: 33,), 
      ),
    ));
  }
}