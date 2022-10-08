import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_test_kurye_youtube/constant.dart';

class SocketService{
  static IO.Socket? socket;

  void connected(){
    socket = IO.io(
      socketUrl,
      OptionBuilder()
      .setTransports(['websocket'])
      .disableAutoConnect()
      .build()
    );
    init();
  }

  static void init(){
    socket!.connect();
    socket!.onConnect((data){
      log("Socket Bağlandı!!",name: "SocketService");
       socket!.emit("orderJoin", "46");
    });
  }
}