import 'package:web_socket_channel/io.dart';
import 'dart:convert';

class CatSocket{
  Function callback;
  CatSocket(this.callback){
    initCommunication();
  }

  String url = "ws://ec2-3-8-202-127.eu-west-2.compute.amazonaws.com:3000/websocket/categories";
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
    send(json.encode({
      "action": action,
      "data": data
    }));
  }

  onMessageReceived(message){
    established = true;
    Map msg = json.decode(message);
    switch(msg['action']){
      case 'update_task_state':
        callback(msg['task_name'], msg['task_state']);
        break;
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