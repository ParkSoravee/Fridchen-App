import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MySocket {
  // late IO.Socket socket;
  static void initSocket() {
    try {
      IO.Socket socket =
          IO.io('http://ebfc-58-11-2-212.ngrok.io', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // IO.Socket socket = IO.io(
      //     'http://ebfc-58-11-2-212.ngrok.io',
      //     OptionBuilder()
      //         .setTransports(['websocket']) // for Flutter or Dart VM
      //         .disableAutoConnect() // disable auto-connection
      //         .build());

      // Connect to websocket
      print('connecting socket...');
      socket.connect();
      print('connected');

      socket.onConnect((_) {
        print('connect ${socket.id}');
        socket.emit('msg', 'test');
        socket.emit('foo', 'test');
      });

      socket.on('event', (data) => print(data));

      socket.onDisconnect((_) => print('disconnect'));

      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  // Send Location to Server
  // void test(String str) {
  //   final data = {
  //     'message': 'test',
  //     'sender': 'me',
  //     'recipient': 'chat',
  //     'time': DateTime.now().toUtc().toString().substring(0, 16)
  //   };
  //   socket.emit("test", data);
  // }
}
