import 'package:web_socket_channel/io.dart';
import 'dart:convert';

WebSocketHelper socketHelper = new WebSocketHelper();

class WebSocketHelper{
  String url = "ws://ec2-3-10-228-186.eu-west-2.compute.amazonaws.com:3000/websocket";

  IOWebSocketChannel channel;
  bool established = false;

  initCommunication() async{
    try{
      channel = IOWebSocketChannel.connect(url);
      channel.stream.listen(onMessageReceived);
    }
    catch(e){
      
    }
  }

  reset(){
    if(channel != null){
      if(channel.sink != null){
        channel.sink.close();
        established = false;
      }
    }
  }

  send(String msg){
    if(channel != null){
      if(channel.sink != null && established){
        channel.sink.add(msg);
      }
    }
  }

  sendMessage({String action, String data}){
    socketHelper.send(json.encode({
      "action": action,
      "data": data
    }));
  }

  onMessageReceived(msg){
    established = true;
    Map message = json.decode(msg);
    switch(message['action']){
      case 'update_task_state':
        //updateTaskState();
        break;
      case 'update_points':
        //  ...
      default: 

    }
  }

  

  
  /*
    try{
      
        channel = IOWebSocketChannel.connect(url);
        headers: {
          'X-DEVICE-ID': "deviceIdentity",
          'X-TOKEN': "token",
          'X-APP-ID': "applicationId",
        }
      );
    } 
    catch(e){

    }

    channel.stream.listen(
      (message){
        /*...*/
      },
      onError: (error, StackTrace stackTrace){
        // error handling
      },
      onDone: (){
        // communication has been closed 
      }
    );*/
}