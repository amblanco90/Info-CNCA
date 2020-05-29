import 'package:InfoCNCA/providers/nodosProvider.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/buildContainer.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class NodoList extends StatefulWidget {
  NodoList({Key key}) : super(key: key);

  @override
  _NodoListState createState() => _NodoListState();
}

class _NodoListState extends State<NodoList> {
  final nodosProvider = NodosProvider();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 10.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: BoldText("Nodos", 20.0, kblack)),
        ),
        Container(
            height: 150.0,
            child: StreamBuilder(
              stream: nodosProvider.getAllNodos(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container(child: Center(child:CircularProgressIndicator()),);
                }
                List<DocumentSnapshot> docs = snapshot.data.documents;

                return PageIndicatorContainer(
                  indicatorColor: korangelite,
                  length: docs.length,
                  
                  child: PageView.builder(
                    controller: PageController(
                      viewportFraction: 1,
                      initialPage: 1),
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final id = docs[index].documentID;
                      final nombre = docs[index].data["Nombre"];
                      Map<String, dynamic> data = docs[index].data;
                      return nombre!="Todos"?buildContainer(context,data["foto"],data["Nombre"],data["Direccion"],data["Telefono"],data["Latitud"],data["Longitud"]):null;
                    },
                  ),
                );
              },
            )),
      ],
    );
  }
}
