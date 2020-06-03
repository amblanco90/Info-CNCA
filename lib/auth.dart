import 'package:InfoCNCA/helpers/appData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:InfoCNCA/Screens/Home.dart';
import 'package:InfoCNCA/Screens/SignInPage.dart';
import 'package:load/load.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:InfoCNCA/widgets/dialogs.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final firestoreInstance = Firestore.instance;

  Future<FirebaseUser> signIn(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final AuthCredential credentials = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    AuthResult userDetails =
        await _firebaseAuth.signInWithCredential(credentials);
    if (userDetails.user.email.contains("misena.edu.co") == false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      FirebaseAuth.instance.signOut();
      _googleSignIn.signOut();
      prefs.remove('CorreoSena');
    } else {
      firestoreInstance
          .collection("Usuarios")
          .where("Correo", isEqualTo: userDetails.user.email)
          .getDocuments()
          .then((val) async {
        if (val.documents.length != 0) {
          print("TIPO DE VALOR: " + val.documents[0].data.toString());
          appData.rol=val.documents[0].data["Derechos"];
           await prefs.setString('rol', appData.rol);
        } else {
          createUser(userDetails.user.displayName, userDetails.user.email,
              userDetails.user.photoUrl);
              appData.rol="Usuario";
               await prefs.setString('rol', appData.rol);

          showDialog(
              context: context,
              builder: (BuildContext context) => GeneralDialog(
                  title: "¡Bienvenido!",
                  description: "Su registro ha sido exitoso",
                  buttonText: "Aceptar"));
          print(
              "usuarioooooooooooooooooooooooooooo creadoooooooooooooooooooooooo");
        }
      });

      await prefs.setString('CorreoSena', userDetails.user.email);
     
      appData.email = userDetails.user.email;
      

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));

      return userDetails.user;
    }
  }

  Future<void> signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseAuth.instance.signOut();
    _googleSignIn.signOut();
    prefs.remove('CorreoSena');
    prefs.remove('rol');
    appData.email = null;
    appData.rol=null;
   print( prefs.get("CorreoSena"));

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignInPage()));
  }

  createUser(nombre, email, fotoUrl) {
    final user = {
      "Correo": email,
      "Derechos": "Usuario",
      "Imagen": fotoUrl,
      "Nombre": nombre
    };

    firestoreInstance.collection("Usuarios").add(user).whenComplete(() {
      GeneralDialog(
          title: "¡Registro exitoso!", description: "", buttonText: "aceptar");
    });
  }

  Future getUser(email) async {
    firestoreInstance
        .collection("Usuarios")
        .where("Correo", isEqualTo: email)
        .getDocuments()
        .then((val) {
      if (val.documents.length != 0) {
        return true;
      } else {
        return false;
      }
    });
  }
}
