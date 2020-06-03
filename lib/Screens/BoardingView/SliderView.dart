import 'dart:async';

import 'package:flutter/material.dart';
import 'package:InfoCNCA/Screens/BoardingView/sliderDots.dart';
import 'package:InfoCNCA/Screens/BoardingView/sliderItems.dart';
import 'package:InfoCNCA/utils/CitiesImage.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';

import 'Slider.dart';

class SliderLayoutView extends StatefulWidget {
  final imagen;
  final titulo;
  final texto;

  SliderLayoutView({this.imagen,this.titulo,this.texto});

  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}

class _SliderLayoutViewState extends State<SliderLayoutView> {
 

  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
    super.dispose();
    
  }

  _onPageChanged(int index) {
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Container(
    color:  Color.fromRGBO(250, 152, 58,0.9),
    child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
        padding: EdgeInsets.all(20.0),
        child: Card(
           shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 25.0,
              child: Container(
                 height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width ,
                child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                  FlatButton(
                        onPressed:()=>Navigator.pop(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(Icons.close)
                        ],
                      )
                      ),
                
                  CitiesImage(widget.imagen, ""),
                  SizedBox(height:10),
                  Text(widget.titulo,style:TextStyle(fontFamily:"Nunito",fontWeight: FontWeight.bold,fontSize: 17.0)),
                  SizedBox(height:10),
                  parrafo(widget.texto),
                  
            ],
          ),
              ),
        )),
      ],
    ),
  );
}


parrafo(texto){

  
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
                padding: EdgeInsets.only(right:30.0,left:30.0),
                height: 250.0,
                child: SingleChildScrollView(
                  child: Text(
                  texto, 
                  textAlign:TextAlign.justify,
                  style: TextStyle(fontFamily:"nunito", fontSize:17.0),)
                  )),
  );
}