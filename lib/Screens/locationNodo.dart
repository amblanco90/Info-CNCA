import 'package:InfoCNCA/helpers/appData.dart';
import 'package:InfoCNCA/helpers/location.dart';
import 'package:InfoCNCA/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:load/load.dart';

class LocationNodo extends StatefulWidget {
  final direccion;
  final latitud;
  final longitud;
  final nombre;
  LocationNodo({this.nombre, this.latitud, this.longitud, this.direccion});
  @override
  _LocationNodoState createState() => _LocationNodoState();
}

class _LocationNodoState extends State<LocationNodo> {
  String _platformVersion = 'Unknown';
  MapboxNavigation _directions;

  bool _arrived = false;

  double _distanceRemaining, _durationRemaining;
  final location = LocationService();

  map(NavigationMode nav) async {
     showLoadingDialog();
      location.getLocation().then((val) async {
     appData.location = val;
     firemap(nav);
     
    });
    
    
  }

  Future firemap(NavigationMode nav) async {
    hideLoadingDialog();
    return  await _directions.startNavigation(
        origin: Location(
            name: "Mi úbicación",
            latitude: appData.location.latitude,
            longitude: appData.location.longitude),
        destination: Location(
            name: widget.nombre,
            latitude: widget.latitud,
            longitude: widget.longitud),
        mode: nav,
        simulateRoute: false,
        language: "es",
        units: VoiceUnits.metric);
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (!mounted) return;

    _directions = MapboxNavigation(onRouteProgress: (arrived) async {
      _distanceRemaining = await _directions.distanceRemaining;
      _durationRemaining = await _directions.durationRemaining;

      setState(() {
        _arrived = arrived;
      });
      if (arrived) {
        await Future.delayed(Duration(seconds: 3));
        await _directions.finishNavigation();
      }
    });

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _directions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationService = LocationService();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BoldText("Dirección", 20.0, kblack),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: kgreyDark,
                      size: 15.0,
                    ),
                    NormalText(widget.direccion, kgreyDark, 15.0),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 2,
                  color: kgreyFill,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: <Widget>[
                    BoldText("Ver en mapa", 20.0, kdarkBlue),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        "assets/location.gif",
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.width - 100,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    NormalText("Elige tu medio de transporte", kdarkBlue, 15.0),
                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: 
                    <Widget>[
                      IconButton(
                          onPressed: () {
                            map(NavigationMode.walking);
                          },
                          icon: Icon(FontAwesomeIcons.walking,color: kdarkBlue,)),
                      IconButton(
                          onPressed: () {
                            map(NavigationMode.drivingWithTraffic);
                          },
                          icon: Icon(FontAwesomeIcons.bus,color: kdarkBlue,)),

                      IconButton(
                          onPressed: () {
                            map(NavigationMode.cycling);
                          },
                          icon: Icon(FontAwesomeIcons.biking,color: kdarkBlue,))
                    ])
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
