import 'package:InfoCNCA/helpers/appData.dart';
import 'package:InfoCNCA/providers/noticiasProvider.dart';
import 'package:InfoCNCA/utils/BestRatedImage.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:InfoCNCA/utils/emptyList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaNoticia extends StatefulWidget {
  final filtro;
  final header;
  ListaNoticia({Key key,this.filtro,this.header}) : super(key: key);


  @override
  _ListaNoticiaState createState() => _ListaNoticiaState();
}

class _ListaNoticiaState extends State<ListaNoticia> {
  final noticiasProvider = NoticiasProvider();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 16.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: BoldText(widget.header, 20.0, kblack)),
      ),
      Container(
        width: 400,
        height: 250,
        child: StreamBuilder(
          stream: noticiasProvider.getAllNoticias(widget.filtro),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return EmptyList();
            }
            List<DocumentSnapshot> docs = snapshot.data.documents;

            return docs.length!=0?ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                final id = docs[index].documentID;

                Map<String, dynamic> data = docs[index].data;
                return BestRatedImage(
                    data["Imagen"], data["Titulo"], data["Cuerpo"], id,data["ImagePath"],data["Destinatario"]);
              },
            ):EmptyList();
          },
        ),
      ),
    ]));
  }
}
