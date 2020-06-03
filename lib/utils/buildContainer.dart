import 'package:InfoCNCA/Screens/OverViewScreen.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:flutter/material.dart';
Widget buildContainer(context,foto,nombre,direccion,telefono,latitud,longitud) {

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return OverViewPage(nombre: nombre,direccion: direccion,telefono: telefono ,foto: foto,latitud: latitud,longitud: longitud,);
            }));
          },
          child: Container(
            width: 320,
            height: 120,
            
            child: Container(
                width: 300,
                height: 200,
               
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
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: AssetImage("assets/two.png"), 
                            image: NetworkImage(foto)
                            ))
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: BoldText(nombre, 15.0, kblack)),
                        
                       
                       
                        SizedBox(height: 14),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: 90,
                            ),
                            BoldText("Ver mas", 12.0, korange),
                            Icon(
                              Icons.navigate_next,
                              size: 15.0,
                              color: korange,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
        Container(height:10.0)
      ],
    );
  }

 