import 'package:InfoCNCA/Screens/SignInPage.dart';
import 'package:InfoCNCA/auth.dart';
import 'package:InfoCNCA/providers/userProvider.dart';
import 'package:InfoCNCA/widgets/confirmationDialog.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:InfoCNCA/utils/forms.dart';
import 'package:InfoCNCA/widgets/dropDownWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final database = Authentication();
  final userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: userProvider.getUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData) {
            return Center(
                child: Icon(
              FontAwesomeIcons.spinner,
              color: korange,
            ));
          } else {
            List<DocumentSnapshot> docs = snapshot.data.documents;

            return Stack(
              children: <Widget>[
                Scaffold(
                  backgroundColor: korange,
                  appBar: AppBar(
                    backgroundColor: korange,
                    title: BoldText("Perfil", 25, kwhite),
                    centerTitle: true,
                    elevation: 0.0,
                  ),
                  body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Container(
                                width: 150.0,
                                height: 150.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                          docs[0].data["Imagen"],
                                          scale: 0.5,
                                        )))),
                          ),
                          SizedBox(height: 20.0),
                          Center(
                              child: BoldText(
                                  docs[0].data["Nombre"], 15.0, kwhite)),
                          Center(
                              child: NormalText(
                                  docs[0].data["Correo"], kwhite, 15.0)),
                          SizedBox(
                            height: 40.0,
                          ),
                          Center(
                              child: BoldText(
                                  'ACCIONES DISPONIBLES', 15.0, kwhite)),
                          FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      ConfirmationDialog(
                                          description:
                                              "¿Está seguro de que  desea eliminar su cuenta?",
                                          function: () {
                                            userProvider
                                                .deleteUser(docs[0].documentID);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignInPage()));
                                          }));
                            },
                            child: Text(
                              "Eliminar mi cuenta",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kwhite,
                                fontFamily: "Nunito",
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              database.signOut(context);
                            },
                            child: Text(
                              "Cerrar sesión",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kwhite,
                                fontFamily: "Nunito",
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          ColorizeAnimatedTextKit(
                              onTap: () {
                                print("Tap Event");
                              },
                              text: [
                               "Powered by: ADSI 52"
                              ],
                              textStyle:
                                  TextStyle(fontSize: 15.0, fontFamily: "Nunito"),
                              colors: [
                                Colors.white,
                                Colors.purple,
                                Colors.blue,
                                Colors.yellow,
                                Colors.red,
                              ],
                              textAlign: TextAlign.center,
                              alignment:
                                  AlignmentDirectional.center // or Alignment.topLeft
                              ),
                              ColorizeAnimatedTextKit(
                              onTap: () {
                                print("Tap Event");
                              },
                              text: [
                               "Email: alexa050802@gmail.com"
                              ],
                              textStyle:
                                  TextStyle(fontSize: 15.0, fontFamily: "Nunito"),
                              colors: [
                                Colors.white,
                                Colors.purple,
                                Colors.blue,
                                Colors.yellow,
                                Colors.red,
                              ],
                              textAlign: TextAlign.center,
                              alignment:
                                  AlignmentDirectional.center // or Alignment.topLeft
                              )
                        ]),
                  ),
                ),
                
              ],
            );
          }
        },
      ),
    );
  }
}
