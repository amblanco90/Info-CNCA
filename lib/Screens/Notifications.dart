import 'package:InfoCNCA/Screens/BoardingView/SliderView.dart';
import 'package:InfoCNCA/providers/normalNotificationsProvider.dart';
import 'package:InfoCNCA/providers/noticiasProvider.dart';
import 'package:InfoCNCA/utils/emptyList.dart';
import 'package:InfoCNCA/widgets/dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:load/load.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final notificacionesProvider = NormalNotificationsProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          backgroundColor: kwhite,
          title: BoldText("Notificaciones", 25, kblack),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: StreamBuilder(
          stream: notificacionesProvider.getAllNotificaciones(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Container(child: CircularProgressIndicator()));
            }
            List<DocumentSnapshot> docs = snapshot.data.documents;

            return docs.length != 0
                ? ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final id = docs[index].documentID;

                      Map<String, dynamic> data = docs[index].data;
                      return notification(data["Titulo"], data["Cuerpo"],
                          data["Id"], data["fecha"], data["hora"]);
                    },
                  )
                : EmptyList();
          },
        ));
  }

  Widget notification(destinatario, cuerpo, id, fecha, Hora) {
    final noticiasProvider = NoticiasProvider();

    return GestureDetector(
      onTap: () {
        print("tap");
        showLoadingDialog();
        noticiasProvider.getNoticia(id, destinatario).then((value) {
          print(value.exists);
          if (value.exists == false) {
            // ignore: missing_return
            hideLoadingDialog();
            return showDialog(
                context: context,
                builder: (BuildContext context) => GeneralDialog(
                    title: "Anuncio no disponible",
                    description: "Este anuncio ha sido borrado",
                    buttonText: "Aceptar"));
          }
          if (value.exists == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => FutureBuilder(
                        future: noticiasProvider.getNoticia(id, destinatario),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          DocumentSnapshot docs = snapshot.data;
                          hideLoadingDialog();

                          print(docs);
                          if (!snapshot.hasData) {
                            return Center(
                              child:
                                  Container(child: CircularProgressIndicator()),
                            );
                          }
                          Map<String, dynamic> data = docs.data;
                          return SliderLayoutView(
                            imagen: data["Imagen"],
                            titulo: data["Titulo"],
                            texto: data["Cuerpo"],
                          );
                        })));
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        height: 100,
        child: Card(
          elevation: 2,
          child: Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: Color(0xffFFEEE0),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BoldText(destinatario, 15.0, kblack),
                    CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 5.0,
                    ),
                  ],
                ),
                NormalText(cuerpo, kgreyDark, 16),
                NormalText(fecha + " " + Hora, kdarkBlue, 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
