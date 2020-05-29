import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:flutter/material.dart';
class ConfirmationDialog extends StatelessWidget {
  final String  description;
  final Function function;

  ConfirmationDialog({
   
    @required this.description,
    @required this.function,
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // To make the card compact
            children: <Widget>[
              
              
              Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Nunito",
                        fontSize: 15.0,
                      ),
                    ),
              SizedBox(height: 24.0),
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
                    onPressed: function,
                    child: Text(
                      "Aceptar",
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


class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 20.0;
}
