import 'dart:io';

import 'package:InfoCNCA/Screens/Noticias.dart';
import 'package:flutter/material.dart';
import 'package:InfoCNCA/utils/BestRatedImage.dart';
import 'package:InfoCNCA/utils/Buttons.dart';
import 'package:InfoCNCA/utils/RecommendationImage.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:InfoCNCA/utils/forms.dart';
import 'package:InfoCNCA/widgets/UsuariosList.dart';
import 'package:InfoCNCA/widgets/dropDownWidget.dart';
import 'package:image_picker/image_picker.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  
  
  TabController tabController;
  
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite,
        title: Container(
            width: 40.0, height: 40.0, child: Image.asset('assets/two.png')),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Scaffold(
        backgroundColor: kwhite,
        appBar: TabBar(
          labelColor: kdarkBlue,
          labelStyle:
              TextStyle(fontFamily: "nunito", fontWeight: FontWeight.bold),
          controller: tabController,
          indicatorColor: kdarkBlue,
          tabs: <Widget>[
            Tab(text: "Administrar usuarios"),
            Tab(text: "Noticias"),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            ListaUsuarios(),
            NoticiasGeneradas()
            
          ],
          controller: tabController,
        ),
      ),
    );
  }
}


