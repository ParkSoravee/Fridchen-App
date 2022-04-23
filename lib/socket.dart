import 'dart:convert';

import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/providers/tags.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MySocket {
  // late IO.Socket socket;
  static void initSocket() {
    try {
      IO.Socket socket = IO.io(dotenv.env['SOCKET'], <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Connect to websocket
      print('connecting socket...');
      socket.connect();
      print('connected');

      socket.onConnect((_) {
        print('connect ${socket.id}');
        print('emiting');
        socket.emit(
            'joinRoom',
            json.encode({
              'room': '123456b',
            }));
        socket.emit(
            'newfridge',
            json.encode({
              'name': 'hello',
              'countLeft': 99,
              'unit': 'Grams',
              'exp': DateTime(2022, 2, 8).toIso8601String(),
              'tags': [
                {
                  '2': 'Vagetable',
                },
                {'4': 'Fresh'},
              ],
            }));
        print('emited');
      });

      socket.on('newfridge', (data) => print(data));
      socket.on('message', (data) => print(data));
      socket.on('roomUsers', (data) => print('room user:' + data.toString()));

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
