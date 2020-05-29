import 'package:flutter/material.dart';

import 'TextStyles.dart';
import 'consts.dart';
import 'forms.dart';

class ImageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Container(
      height: 190.0,
      width: 400.0,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration:
BoxDecoration(
  color: const Color(0xff7c94b6),
  image: new DecorationImage(
    fit: BoxFit.cover,
    colorFilter: 
      ColorFilter.mode(Colors.black.withOpacity(0.7), 
      BlendMode.dstATop),
    image: AssetImage("assets/three.png")
  ),
),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130.0, left: 20, right: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
