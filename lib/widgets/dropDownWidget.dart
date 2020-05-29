import 'package:InfoCNCA/providers/nodosProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownRol extends StatefulWidget {
  final rol;
   final Function (String) derechos;
  DropDownRol({Key key, this.rol,this.derechos}) : super(key: key);

  @override
  _DropDownRolState createState() => _DropDownRolState();
}

class _DropDownRolState extends State<DropDownRol> {
  
  String _chosenValue;
  @override
  Widget build(BuildContext context) {
    return Container(
        
        child: Center(
          child: DropdownButton<String>(
            focusColor: Color(0xffFFEEE0),
            style: TextStyle(
                  color: Colors.grey.shade700,
                  
                  fontFamily: "Nunito",
                  fontSize: 18.0,
                ),
            value: _chosenValue==null?widget.rol:_chosenValue,
            items: <String>['Usuario','Administrador']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,textAlign: TextAlign.center,),
              );
            }).toList(),
            onChanged: (String value) {
              setState(() {
                _chosenValue = value;
                widget.derechos(value);
              });
            },
          ),
        ),
      
    );
  }
}

class DropdownDestinatarios extends StatefulWidget {
  final Function (String) destinatario;
  DropdownDestinatarios({Key key,this.destinatario}) : super(key: key);

  @override
  _DropdownDestinatariosState createState() => _DropdownDestinatariosState();
}

class _DropdownDestinatariosState extends State<DropdownDestinatarios> {
  String _chosenValue = 'Todos';
  @override
  Widget build(BuildContext context) {
    final nodosProvider = NodosProvider();
    return StreamBuilder(
      stream: nodosProvider.getDropdown() ,
      
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return CupertinoActivityIndicator();
        }


        return Container(
        
        child: Center(
          child: DropdownButton<String>(
            focusColor: Color(0xffFFEEE0),
            style: TextStyle(
                  color: Colors.grey.shade700,
                  
                  fontFamily: "Nunito",
                  fontSize: 12.0,
                ),
            value: _chosenValue,
            items: snapshot.data.documents
                .map<DropdownMenuItem<String>>((DocumentSnapshot value) {
              return DropdownMenuItem<String>(
                value: value.data["Nombre"],
                child: Text( value.data["Nombre"],textAlign: TextAlign.center,),
              );
            }).toList(),
            onChanged: (String value) {
              setState(() {
                _chosenValue = value;
                widget.destinatario(value);
                
              });
            },
            
          ),
        ),
      
    );
  

      },
    );
    
  }
}

class DropDownImortancia extends StatefulWidget {
  final Function(String) importancia;
  DropDownImortancia({Key key,this.importancia}) : super(key: key);

  @override
  _DropDownImortanciaState createState() => _DropDownImortanciaState();
}

class _DropDownImortanciaState extends State<DropDownImortancia> {
   String _chosen = 'Normal';
  @override
  Widget build(BuildContext context) {
  
    return Container(
        
        child: Center(
          child: DropdownButton<String>(
            focusColor: Color(0xffFFEEE0),
            style: TextStyle(
                  color: Colors.grey.shade700,
                  
                  fontFamily: "Nunito",
                  fontSize: 12.0,
                ),
            value: _chosen,
            items: <String>['Normal','Urgente']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,textAlign: TextAlign.center,),
              );
            }).toList(),
            onChanged: (String value) {
              _chosen = value;
              widget.importancia(value);
              setState(() {
                
              });
            },
          ),
        ),
      
    );
  }
}