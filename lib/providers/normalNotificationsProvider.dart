 
 import 'package:InfoCNCA/providers/sendNotificationProvider.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';

class NormalNotificationsProvider {

   final fb = Firestore.instance.collection('Notificaciones');
    final sendNotification = SendNotificationsProvider();
   guardarNotificaciones(titulo,texto,id,importancia) async {
     final notf = {
        "Titulo": titulo,
        "Cuerpo": texto,
        "Id": id,
        "fecha": DateTime.now().day.toString()+ "/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString(),
        "hora": DateTime.now().hour.toString()+":"+DateTime.now().minute.toString()
        
      };

      DocumentReference addNotice = await fb.add(notf);

      sendNotification.sendAndRetrieveMessage(titulo);
      
   }

   getAllNotificaciones(){
     final notf = fb.orderBy("hora",descending: false).limit(20).snapshots();
     return notf;

   }
   

   
 }