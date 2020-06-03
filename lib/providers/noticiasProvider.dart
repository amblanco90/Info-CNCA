
import 'package:InfoCNCA/providers/normalNotificationsProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class NoticiasProvider {
  final fb = Firestore.instance.collection('Noticias');
  
  final notificacionesProvider = NormalNotificationsProvider();

  Future guardarNoticia(
      imagen, titulo, texto, destinatario, importancia) async {
    if (imagen != null) {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('noticias/${Path.basename(imagen.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(imagen);
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) async {
        final user = {
          "Titulo": titulo,
          "Cuerpo": texto,
          "Imagen": fileURL,
          "Destinatario": destinatario,
          "Importancia": importancia,
          "ImagePath": '${Path.basename(imagen.path)}',
          "HoraFecha":DateTime.now()
        };

      DocumentReference addNotice = await fb.document(destinatario).collection(destinatario).add(user);
        
          if (importancia == "Urgente") {
          notificacionesProvider.guardarNotificaciones(
              titulo, texto, addNotice.documentID,importancia);
          print(addNotice.documentID);
          }
      });
    } else {
      final user = {
        "Titulo": titulo,
        "Cuerpo": texto,
        "Imagen": imagen,
        "Destinatario": destinatario,
        "Importancia": importancia,
        "HoraFecha":DateTime.now()
      };

      DocumentReference addNotice = await fb.document(destinatario).collection(destinatario).add(user);
      if (importancia == "Urgente") {

        notificacionesProvider.guardarNotificaciones(
            destinatario, titulo, addNotice.documentID,importancia);
        print(addNotice.documentID);
      }
    }
  }

  getAllNoticias(destino){
    final noticias = fb.document(destino).collection(destino).orderBy("HoraFecha",descending: true).snapshots();
    return noticias;
  }

  Future actualizarNoticia(imagen, titulo, texto, path, id,destino) async {
    if (imagen != null) {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('noticias/${Path.basename(imagen.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(imagen);
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        FirebaseStorage.instance
            .ref()
            .child('noticias/$path')
            .delete()
            .whenComplete(() {
          print("IMAGEN BORRADA EXITOSAMENTE");
        });

        fb.document(destino).collection(destino).document(id).updateData({
          "Titulo": titulo,
          "Cuerpo": texto,
          "Imagen": fileURL,
          "ImagePath": '${Path.basename(imagen.path)}',
        }).whenComplete(() {
          print("Derechos cambiados exitosamente");
        });
      });
    } else {
      fb.document(destino).collection(destino).document(id).updateData({
        "Titulo": titulo,
        "Cuerpo": texto,
      }).whenComplete(() {
        print("Derechos cambiados exitosamente");
      });
    }
  }

  Future deleteNoticia(path, id,destino) async {
    fb.document(destino).collection(destino).document(id).delete();
    FirebaseStorage.instance
        .ref()
        .child('noticias/$path')
        .delete()
        .whenComplete(() {
      print("IMAGEN BORRADA EXITOSAMENTE");
    });
  }

  Future<DocumentSnapshot>getNoticia(id,destinatario) {
    return fb.document(destinatario).collection(destinatario).document(id).get();
  }
}
