import 'package:InfoCNCA/Screens/NuevoAnuncio.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:flutter/material.dart';

class EditarNoticia extends StatefulWidget {
  final String imageUrl;
  final String titulo;
  final String texto;
  final id;
  final path;
  final destino;

 EditarNoticia({this.imageUrl, this.titulo, this.texto, this.id, this.path,this.destino});

  @override
  _EditarNoticiaState createState() => _EditarNoticiaState();
}

class _EditarNoticiaState extends State<EditarNoticia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.grey.shade50,
            title: BoldText("Editar anuncio", 20.0, kblack),
          ),
          body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          
                      
                        ],
                      ),
                       SizedBox(
                        height: 16,
                      ),
                      Formulario(titulo:widget.titulo,texto:widget.texto,id:widget.id,path:widget.path,destino: widget.destino,),
                      SizedBox(
                        height: 16,
                      ),
                      
                       GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            
                            child: BoldText("Volver", 15.0, kdarkBlue))),
                    ],
                  ),
                ),
              ),
    );
  }
}