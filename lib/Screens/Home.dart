import 'package:InfoCNCA/helpers/appData.dart';
import 'package:InfoCNCA/providers/pushNotificationsProvider.dart';
import 'package:InfoCNCA/utils/bottomBars.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:InfoCNCA/Screens/DashBoard.dart';
import 'package:InfoCNCA/utils/TextStyles.dart';
import 'package:InfoCNCA/utils/consts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Notifications.dart';
import 'Orders.dart';
import 'Profile.dart';
import 'SignInPage.dart';

class Home extends StatefulWidget {
  final int;
  Home({this.int});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _cIndex = 0;

  PageController _pageController; 

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.int!=null?widget.int:0
    );
     final pushProvider = PushNotificationProvider();
    pushProvider.initNotifications(context);
    setState(() {
      
    });
   
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBars(int:widget.int,cIndex: _cIndex, incrementTab: (int){
        _incrementTab(int);
      } ,),
      body: SizedBox.expand(
        child: PageView(
          
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _cIndex = index);
          },
          children: listas()
        ),
      ),
    );

    
  }

  
}

listas(){
  if(appData.rol=="Usuario"){
    return <Widget>[
            Dashboard(),
            Notifications(),
            Profile(),
          ];
  }
  else{

    return <Widget>[
            Dashboard(),
            Orders(),
            Notifications(),
            Profile(),
          ];

  }
  
}
