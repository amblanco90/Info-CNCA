import 'package:flutter/material.dart';

import 'TextStyles.dart';
import 'consts.dart';

class CitiesImage extends StatelessWidget {
  final String imgUrl;
  final String city;

  CitiesImage(this.imgUrl, this.city);

  @override
  Widget build(BuildContext context) {
      return Container(
        width: 150,
        height: 150,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            SizedBox(height: 10.0,),
            Container(
                width: 150,
                height: 150,
                child: ClipRRect(
                    borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage("assets/two.png"), 
                      image: NetworkImage(
                        imgUrl!=null?imgUrl:"assets/two.png"
                      )))),
            Container(
              width: 160,
              height: 160,
              child: Align(
                  alignment: Alignment.center,

                  child: BoldText(city,30,kwhite)),
            )
          ],
        ),
      );

  }
}
