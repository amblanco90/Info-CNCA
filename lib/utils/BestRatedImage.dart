import 'package:InfoCNCA/Screens/BoardingView/SliderView.dart';
import 'package:InfoCNCA/Screens/EditarNoticia.dart';
import 'package:InfoCNCA/Screens/NuevoAnuncio.dart';
import 'package:InfoCNCA/helpers/appData.dart';
import 'package:InfoCNCA/providers/noticiasProvider.dart';
import 'package:InfoCNCA/widgets/confirmationDialog.dart';
import 'package:InfoCNCA/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:InfoCNCA/Screens/BoardingView/OnBoardingScreen.dart';
import 'package:InfoCNCA/Screens/OverViewScreen.dart';
import 'package:load/load.dart';

import 'TextStyles.dart';
import 'consts.dart';

class BestRatedImage extends StatelessWidget {
  final String imageUrl;
  final String titulo;
  final String texto;
  final id;
  final path;
  final destino;
  final noticiaProvider = NoticiasProvider();

  BestRatedImage(this.imageUrl, this.titulo, this.texto, this.id, this.path, this.destino );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      width: 320,
      child: Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: Color(0xffFFEEE0),
              borderRadius: BorderRadius.circular(15.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                child: ClipRRect(
                    borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: AssetImage(

                              "assets/two.png"),
                          image: imageUrl != null
                              ? NetworkImage(imageUrl)
                              : AssetImage("assets/two.png")),
                    )),
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 150.0, child: BoldText(titulo, 15.0, kblack)),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                     appData.rol!="Usuario"? GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return EditarNoticia(
                                  imageUrl: imageUrl,
                                  titulo: titulo,
                                  texto: texto,
                                  id: id,
                                  path: path,
                                  destino: destino,);
                            }));
                          },
                          child: Container(
                            child: Icon(
                              Icons.edit,
                              color: Colors.orange,
                            ),
                          )):Container(),
                      SizedBox(width: 10.0),
                    appData.rol!="Usuario"?  GestureDetector(
                          onTap: () {
                            showDialog(context: context,
                            builder: (BuildContext context)=>ConfirmationDialog(
                                description:
                                    "¿Está seguro de que desea eliminar este anuncio?",
                                function: () {
                                  showLoadingDialog();
                                  noticiaProvider
                                      .deleteNoticia(path, id,destino)
                                      .whenComplete(() {
                                    Navigator.pop(context);
                                    hideLoadingDialog();
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            GeneralDialog(
                                                title: "¡Proceso exitoso!",
                                                description:
                                                    "Su anuncio se ha eliminado correctamente",
                                                buttonText: "Aceptar"));
                                  });
                                })
                            );
                          },
                          child: Container(
                            child: Icon(
                              Icons.delete,
                              color: Colors.orange,
                            ),
                          )):Container(),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return SliderLayoutView(
                              imagen: imageUrl,
                              titulo: titulo,
                              texto: texto,
                            );
                          }));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            BoldText(
                              "Ver mas",
                              12.0,
                              Colors.orange,
                            ),
                            Icon(
                              Icons.navigate_next,
                              size: 15.0,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
