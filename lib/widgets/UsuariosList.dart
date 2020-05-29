import 'package:InfoCNCA/helpers/appData.dart';
import 'package:InfoCNCA/providers/userProvider.dart';
import 'package:InfoCNCA/utils/emptyList.dart';
import 'package:InfoCNCA/widgets/confirmationDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:InfoCNCA/widgets/dialogs.dart';

class ListaUsuarios extends StatefulWidget {
  ListaUsuarios({Key key}) : super(key: key);

  @override
  _ListaUsuariosState createState() => _ListaUsuariosState();
}

class _ListaUsuariosState extends State<ListaUsuarios> {
  final userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userProvider.getAllUsers(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Container(child: CircularProgressIndicator()));
        }
        List<DocumentSnapshot> docs = snapshot.data.documents;

        return docs.length != 1
            ? ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final id = docs[index].documentID;
                  final correo = docs[index].data["Correo"];
                  Map<String, dynamic> data = docs[index].data;
                  return Visibility(
                      visible: appData.email == correo ? false : true,
                      child: UsuariosList(
                          correo: data["Correo"],
                          nombre: data["Nombre"],
                          derechos: data["Derechos"],
                          foto: data["Imagen"],
                          id: id));
                },
              )
            : EmptyList();
      },
    );
  }
}

class UsuariosList extends StatefulWidget {
  final nombre;
  final correo;
  final derechos;
  final foto;
  final id;
  UsuariosList(
      {Key key, this.correo, this.derechos, this.nombre, this.foto, this.id})
      : super(key: key);

  @override
  _UsuariosListState createState() => _UsuariosListState();
}

class _UsuariosListState extends State<UsuariosList> {
  final userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.all(8.0),
        elevation: 2,
        child: Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Color(0xffFFEEE0),
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(180.0),
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: "assets/two.png",
                      image: widget.foto),
                ),
              ),
              SizedBox(
                width: 17,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 140.0,
                    child: Text(
                      widget.nombre,
                      maxLines: null,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(0xffFC9535),
                          fontFamily: "Nunito",
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: 140.0,
                    child: Text(
                      widget.correo,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: "Nunito", fontSize: 12),
                    ),
                  )
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => ConfirmationDialog(
                          description:
                              "¿Está seguro de que desea eliminar este usuario?",
                          function: () {
                            userProvider.deleteUser(widget.id);
                            Navigator.pop(context);
                          }));
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                        color: Color(0xffFBB97C),
                        borderRadius: BorderRadius.circular(13)),
                    child: Icon(Icons.delete, color: kdarkBlue)),
              ),
              Spacer(),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                          nombre: widget.nombre,
                          correo: widget.correo,
                          derechos: widget.derechos,
                          id: widget.id));
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                        color: Color(0xffFBB97C),
                        borderRadius: BorderRadius.circular(13)),
                    child: Icon(Icons.edit, color: kdarkBlue)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
