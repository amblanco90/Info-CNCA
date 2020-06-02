import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

class SendNotificationsProvider {
  final String serverToken =
      'AAAAFcTVPk8:APA91bFsaQPP7bdeN6krLjgUXUaExHNitCz6cjnSDrm95ZtmbRnEosiXKNPFvN8axCj3lPyakf6hkWkUYTJNN5vlFVxRXV-kHh_oZdrcf1lVEnidkvMbgfYSXr5i2VcGVbdP9OKZI4Wd';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendAndRetrieveMessage(title) async {
    if(Platform.isAndroid){

      await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': title,
            'title': 'Nueva notificación'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': '/topics/Notificaciones',
        },
      ),
    ).then((Response val){
      print("VAL"+val.statusCode.toString());
    });

    
  }

    }
    
}
