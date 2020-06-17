import 'package:InfoCNCA/auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:InfoCNCA/Screens/DashBoard.dart';
import 'package:InfoCNCA/utils/Buttons.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:InfoCNCA/utils/delayedAnimations.dart';
import 'package:InfoCNCA/utils/forms.dart';
import 'package:InfoCNCA/widgets/dialogs.dart';

import 'Home.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  final database = Authentication();
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return Scaffold(
        backgroundColor: korange,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AvatarGlow(
                endRadius: 90,
                duration: Duration(seconds: 2),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 2),
                startDelay: Duration(seconds: 1),
                child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Center(
              child: Container(
                  width: 150 ,
                  child: Image.asset("assets/logoapp.png")),
            ),
            radius: 66,
          ),),
              ),
               BoldText("Info",35.0,kdarkBlue),
              TypewriterAnimatedTextKit(
                text: ["CNCA"],
                textStyle: TextStyle(fontSize: 30.0,color: kwhite,fontFamily: "nunito"),

                speed: Duration(milliseconds: 1000),
              ),
              DelayedAnimation(
                child: Text(
                  "Bienvenido",
                  style: TextStyle(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                ),
                delay: delayedAmount + 1000,
              ),
              
              SizedBox(
                height: 30.0,
              ),
              
              
              DelayedAnimation(
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
                delay: delayedAmount + 4000,
              ),
              SizedBox(
                height: 50.0,
              ),
              ColorizeAnimatedTextKit(
                              onTap: () {
                                print("Tap Event");
                              },
                              text: [
                               "Powered by: ADSI 52"
                              ],
                              textStyle:
                                  TextStyle(fontSize: 15.0, fontFamily: "Nunito"),
                              colors: [
                                Colors.white,
                                Colors.purple,
                                Colors.blue,
                                Colors.yellow,
                                Colors.red,
                              ],
                              textAlign: TextAlign.center,
                              alignment:
                                  AlignmentDirectional.center // or Alignment.topLeft
                              ),
                              ColorizeAnimatedTextKit(
                              onTap: () {
                                print("Tap Event");
                              },
                              text: [
                               "Email: alexa050802@gmail.com"
                              ],
                              textStyle:
                                  TextStyle(fontSize: 15.0, fontFamily: "Nunito"),
                              colors: [
                                Colors.white,
                                Colors.purple,
                                Colors.blue,
                                Colors.yellow,
                                Colors.red,
                              ],
                              textAlign: TextAlign.center,
                              alignment:
                                  AlignmentDirectional.center // or Alignment.topLeft
                              )
                       
              
            ],
          ),
        )
        //

        );
  }

  Widget get _animatedButtonUI => GestureDetector(
        onTap: () {
          database.signIn(context).then((user) {
            if (user == null) {
              print(user);
              showDialog(
                  context: context,
                  builder: (context) => GeneralDialog(
                      title: "Error al iniciar sesión",
                      description:
                          "Por favor ingresa de nuevo con una cuenta misena.",
                      buttonText: "Aceptar"));
            }
          }).catchError((e) => print(e));
        },
        child: Container(
          height: 60,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
                  "Ingresar ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Nunito",
                    fontSize: 20.0, color: kdarkBlue),
                ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
