
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          NormalText("Los registros apereceran aquí",korange, 15.0),
          SizedBox(height:10.0),
          Icon(Icons.add_circle_outline,color: korange,)
        ],
      ),
    );
  }
}