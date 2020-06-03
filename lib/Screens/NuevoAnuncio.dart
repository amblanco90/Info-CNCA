import 'dart:io';

import 'package:InfoCNCA/providers/noticiasProvider.dart';
import 'package:InfoCNCA/utils/Buttons.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:InfoCNCA/utils/forms.dart';
import 'package:InfoCNCA/widgets/dialogs.dart';
import 'package:InfoCNCA/widgets/dropDownWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:load/load.dart';

class Formulario extends StatefulWidget {
  final titulo;
  final texto;
  final id;
  final path;
  final destino;

  Formulario({Key key, this.titulo, this.texto, this.id, this.path, this.destino})
      : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  File _image;
  final controller = TextEditingController();
  final titulo = TextEditingController();
  final _key = GlobalKey<FormState>();
  final noticiaProvider = NoticiasProvider();
  var color = kgreyDark;
  var color2 = Colors.transparent;
  String importancia = 'Normal';
    String destinatario = 'Todos';

  @override
  void initState() {
    super.initState();
    if (widget.id != null || widget.texto != null || widget.titulo != null) {
      titulo.text = widget.titulo;
      controller.text = widget.texto;
    }
  }

  cambioColor() {
    if (_image != null) {
      color = korange;
      color2 = Colors.red;
      controller.text = controller.text;
      setState(() {});
    } else {
      color = kgreyDark;
      color2 = Colors.transparent;
      controller.text = controller.text;
      _image = null;
      setState(() {});
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      cambioColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Form(
        key: _key,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Visibility(
                  visible: widget.id == null ? true : false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      NormalText("Enviar a", korange, 16.0),
                      DropdownDestinatarios(
                        destinatario: (String val) {
                          destinatario = val;
                        },
                      ),
                      NormalText("Importancia", korange, 16.0),
                      DropDownImortancia(
                        importancia: (String val) {
                          importancia = val;
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: getImage,
                                icon: Icon(

                                    Icons.camera_alt, color: color,),
                              ),
                              Positioned(
                                bottom: 27,
                                right: 67,
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.red,
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            NormalForm("Título", titulo),
            SizedBox(
              height: 10.0,
            ),
            BidInput(
              control: controller,
            ),
            SizedBox(
              height: 16,
            ),
            WideButton.bold("Guardar", () {
              if (_key.currentState.validate()) {
                if (widget.id != null) {
                  print("ACTUALIZADA CORRETAMENTE");
                  showLoadingDialog();
                  noticiaProvider
                      .actualizarNoticia(_image, titulo.text, controller.text,
                          widget.path, widget.id,widget.destino)
                      .whenComplete(() {
                    Navigator.pop(context);
                    hideLoadingDialog();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => GeneralDialog(
                            title: "¡Registro exitoso!",
                            description:
                                "Su anuncio se ha actualizado correctamente",
                            buttonText: "Aceptar"));
                  });
                } else {
                  showLoadingDialog();
                  noticiaProvider
                      .guardarNoticia(_image, titulo.text, controller.text,
                          destinatario, importancia)
                      .whenComplete(() {

                     
                    controller.clear();
                    titulo.clear();
                    _image = null;
                    print(_image);
                    cambioColor();
                    
                    hideLoadingDialog();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => GeneralDialog(
                            title: "¡Registro exitoso!",
                            description:
                                "Su anuncio se ha generado correctamente",
                            buttonText: "Aceptar"));
                  });
                }
              }
            }, true),
            SizedBox(
              height: 16,
            ),
          ],
        ));
  }
}
