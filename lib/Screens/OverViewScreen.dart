import 'package:InfoCNCA/helpers/appData.dart';
import 'package:InfoCNCA/helpers/location.dart';
import 'package:flutter/material.dart';
import 'package:InfoCNCA/Screens/infoNodo.dart';
import 'package:InfoCNCA/Screens/locationNodo.dart';
import 'package:InfoCNCA/utils/Buttons.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';


class OverViewPage extends StatefulWidget {
  final nombre;
  final foto;
  final direccion;
  final telefono;
  final latitud;
  final longitud;
  OverViewPage({this.nombre,this.foto,this.telefono,this.direccion,this.latitud,this.longitud});
  @override
  _OverViewPageState createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  final location = LocationService();
  var a;

   @override
  void initState() {
    super.initState();
   location.getLocation().then((val){
     appData.location = val;
    });
  
    tabController = new TabController(length: 2, vsync: this);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: SingleChildScrollView(
        
        child: Stack(
        children: <Widget>[
          Container(
            
              child: FadeInImage(placeholder: AssetImage("assets/two.png"), image: NetworkImage(widget.foto))),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              margin: EdgeInsets.only(top:180),
              height: 700,
              child: Scaffold(
                appBar: TabBar(
                  labelColor: kdarkBlue,
                  labelStyle: TextStyle(
                      fontFamily: "nunito", fontWeight: FontWeight.bold),
                  controller: tabController,
                  indicatorColor: kdarkBlue,
                  tabs: <Widget>[
                    Tab(text: "Informacion general"),
                    Tab(text: "Ubicación"),
                   
                  ],
                ),
                backgroundColor: kwhite,
                body: Stack(
                  children: <Widget>[
                    TabBarView(
                      children: <Widget>[
                        InformacionNodo(nombre: widget.nombre,telefono: widget.telefono,),
                        LocationNodo(nombre: widget.nombre,latitud: widget.latitud,longitud: widget.longitud,direccion: widget.direccion,)

                       ],
                      controller: tabController,
                    ),
                  ],
                ),

                /*Stack(
                  children: <Widget>[
                    Image.asset("assets/hotel.jpg"),





                  ],

                ),*/
              ),
            ),
          ),
          
        ],
      ),
   
      ),
       );

       
  }

 
}
