import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class MySocket {
  late IO.Socket socket;
  void initSocket() {
    try {
      // IO.Socket socket = IO.io('http://localhost:3000');

      socket = IO.io(dotenv.env['SOCKET'], <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Connect to websocket
      socket.connect();

      socket.onConnect((_) {
        print('connect ${socket.id}');
        socket.emit('msg', 'test');
      });

      socket.on('event', (data) => print(data));

      socket.onDisconnect((_) => print('disconnect'));

      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  // Send Location to Server
  void test(String str) {
    final data = {
      'message': 'test',
      'sender': 'me',
      'recipient': 'chat',
      'time': DateTime.now().toUtc().toString().substring(0, 16)
    };
    socket.emit("test", data);
  }
}
