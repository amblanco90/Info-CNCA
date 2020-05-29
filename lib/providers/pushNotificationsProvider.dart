import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:InfoCNCA/Screens/Home.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:InfoCNCA/widgets/dialogs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications(context) {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.subscribeToTopic('Notificaciones');

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {

        String argumento = 'ugu';
        String body ="";
        if(Platform.isAndroid){

          argumento = message['notification']['title'];
          body = message['notification']['body'];
          
         

        }
        _mensajesStreamController.sink.add(argumento); 
        print("onMessage: $message");
        
        _colorfullAlert(body,context);
        
       
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Home(int:2)));
        
      },

      
    );

    

  }

  void _colorfullAlert(texto,context) {
    Flushbar(
                 flushbarPosition: FlushbarPosition.TOP,
                 messageText: Text( "Nuevo anuncio: (Audiencia) "+ texto,style: TextStyle(fontFamily:"nunito"),),
                 dismissDirection: FlushbarDismissDirection.HORIZONTAL, 
                  duration:  Duration(seconds: 7),
                  backgroundColor: korangelite,
                )..show(context);
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
