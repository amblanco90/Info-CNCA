import 'package:InfoCNCA/providers/userProvider.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:InfoCNCA/widgets/dropDownWidget.dart';
import 'package:InfoCNCA/widgets/dropDownWidget.dart';

class CustomDialog extends StatelessWidget {
  final nombre;
  final correo;
  final derechos;
  final id;
  final userProvider = UserProvider();
  String rol;

  CustomDialog({this.nombre,this.correo,this.derechos,this.id});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              BoldText(nombre, 11, Colors.black),
              NormalText(correo, kgreyDark, 10),
                SizedBox(height: 16.0),
              Text(
                "Editar permisos",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              
              
              DropDownRol(rol: derechos, derechos: (String val){
                rol = val;
              },),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text(
                      "Cancelar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.orangeAccent.shade700,
                        fontFamily: "Nunito",
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  FlatButton(
                    onPressed: () {
                       userProvider.updateUserRole(id, rol);
                       Navigator.pop(context);
                    },
                    child: Text(
                      "Guardar",
                      textAlign: TextAlign.center,
                    
                      style: TextStyle(
                        color: Colors.orangeAccent.shade700,
                        fontFamily: "Nunito",
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
       
      ],
    );
  }
}

class GeneralDialog extends StatelessWidget {
  final String title, description, buttonText;

  GeneralDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(buttonText,style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 15.0,
                  color: Colors.orangeAccent.shade700
                ),),
                ),
              ),
            ],
          ),
        ),
        
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 20.0;
}
