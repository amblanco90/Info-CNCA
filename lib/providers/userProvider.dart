
import 'package:InfoCNCA/helpers/appData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final firestoreInstance = Firestore.instance;

  final fb = Firestore.instance.collection('Usuarios');
  storage () async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
     final email = prefs.get("CorreoSena");
     appData.email=email;
     
  }
  
  getAllUsers(){
    final users = fb.snapshots();
    return users;
  }

  getUser()  {

    final selectedUser = fb.where("Correo",isEqualTo:appData.email).snapshots();
    return selectedUser;


  }

  updateUserRole(id,rol){

    fb.document(id).updateData(
      {"Derechos":rol,}).whenComplete((){
      print("Derechos cambiados exitosamente");
    });



  }

  deleteUser(id) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
      FirebaseAuth.instance.signOut();
      _googleSignIn.signOut();
      prefs.remove('CorreoSena');

    fb.document(id).delete().whenComplete((){
      print("USUARIO BORRADOO exitosamente");
    });



  }
  
}