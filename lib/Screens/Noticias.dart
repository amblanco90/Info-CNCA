
import 'package:InfoCNCA/Screens/NuevoAnuncio.dart';
import 'package:InfoCNCA/utils/BestRatedImage.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:flutter/material.dart';

class NoticiasGeneradas extends StatefulWidget {
  NoticiasGeneradas({Key key}) : super(key: key);

  @override
  _NoticiasGeneradasState createState() => _NoticiasGeneradasState();
}

class _NoticiasGeneradasState extends State<NoticiasGeneradas> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        BoldText("Crear anuncio", 20.0, kblack),
                        
                    
                      ],
                    ),
                     SizedBox(
                      height: 16,
                    ),
                    Formulario(),
                    SizedBox(
                      height: 16,
                    ),
                    
                  ],
                ),
              ),
            );
  }
}