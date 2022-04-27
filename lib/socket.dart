import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/auth.dart';
import 'package:fridchen_app/providers/family.dart';
import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/providers/list.dart';
import 'package:fridchen_app/providers/recipes.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MySocket {
  final BuildContext context;
  MySocket(this.context);
  // late IO.Socket socket;
  static Future<void> initSocket(BuildContext context) async {
    try {
      Provider.of<FridgeItems>(context, listen: false).test;
      IO.Socket socket = IO.io(dotenv.env['SOCKET'], <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Connect to websocket
      print('connecting socket...');
      socket.connect();

      socket.onConnect((_) {
        print('connected ${socket.id}');

        print('emiting join family');
        final familyId =
            Provider.of<Families>(context, listen: false).currentFamilyId;
        final userId = Provider.of<Auth>(context, listen: false).userId;

        socket.emit(
          'joinRoom',
          json.encode({
            'family_id': familyId,
            'user_id': userId,
          }),
        );
      });

      socket.on('fridge', (data) async {
        print(data);
        final familyId =
            Provider.of<Families>(context, listen: false).currentFamilyId;
        Provider.of<FridgeItems>(context, listen: false)
            .fetchAndSetItem(familyId);
      });

      socket.on('recipe', (data) {
        print(data);
        final familyId =
            Provider.of<Families>(context, listen: false).currentFamilyId;
        Provider.of<Recipes>(context, listen: false).fetchAndSetItem(familyId);
      });

      socket.on('list', (data) {
        print(data);
        final familyId =
            Provider.of<Families>(context, listen: false).currentFamilyId;
        Provider.of<ListItems>(context, listen: false)
            .fetchAndSetItem(familyId);
      });

      socket.on('message', (data) {
        print(data);
      });

      socket.onDisconnect((_) => print('socket disconnected'));
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
