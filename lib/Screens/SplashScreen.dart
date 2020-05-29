import 'package:InfoCNCA/helpers/appData.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:InfoCNCA/Screens/Home.dart';
import 'package:InfoCNCA/Screens/SignInPage.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BoardingView/OnBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 getStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appData.email=prefs.get("CorreoSena");
    appData.rol=prefs.get("rol");
    print(appData.rol);
    print(prefs.get("CorreoSena")); 
    return prefs;

 }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: korange,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 180.0,
                  height: 180.0,
                  child: Image(image: AssetImage("assets/one.png"))),
              SizedBox(height: 50),
              BoldText("Info", 35.0, kdarkBlue),
              TypewriterAnimatedTextKit(
                text: ["CNCA"],
                textStyle: TextStyle(
                    fontSize: 30.0, color: kwhite, fontFamily: "nunito"),
                speed: Duration(milliseconds: 1000),
              ),
              
              
            ],
          ),
        ));
  }

  @override
   initState(){
    
    super.initState();
    getStorage();
    
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return appData.email!=null? Home():SignInPage();
        }));
      });
    
  }
}
