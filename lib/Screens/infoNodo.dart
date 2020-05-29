import 'package:InfoCNCA/Screens/listaNoticias.dart';
import 'package:flutter/material.dart';
import 'package:InfoCNCA/utils/BestRatedImage.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';

class InformacionNodo extends StatelessWidget {
  final nombre;
  final telefono;
  const InformacionNodo({Key key,this.nombre,this.telefono}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                BoldText(nombre, 20.0, kblack),
                                
                                SizedBox(
                                  height: 10,
                                ),
                               
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  height: 2,
                                  color: kgreyFill,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    BoldText("Otro", 20.0, kblack),
                                    
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                NormalText(
                                    telefono!=""?telefono:"No disponible",
                                    kblack,
                                    12.0),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  height: 2,
                                  color: kgreyFill,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                               
                               ListaNoticia(filtro:nombre,header:"Noticias relacionadas")
                                ],
                            ),
                          );
                          
  }

  
  Column equipmentsItem(IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          icon,
          color: kdarkBlue,
        ),
        NormalText(text, kdarkBlue, 12)
      ],
    );
  }

  
}