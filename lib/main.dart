import 'package:InfoCNCA/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:load/load.dart';
import 'Screens/SplashScreen.dart';

void main() => runApp(
      LoadingProvider(
        loadingWidgetBuilder: (ctx, data) {
          return Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: Container(
                child: CupertinoActivityIndicator(),
                color: Colors.transparent,
              ),
            ),
          );
        },
        child: MaterialApp(
          localizationsDelegates: [
            // ... app-specific localization delegate[s] here
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('es'), // English
            // Chinese *See Advanced Locales below*
            // ... other locales the app supports
          ],
          // ...
          theme: ThemeData(primaryColor: kdarkBlue, accentColor: korangelite),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          title: 'Info-CNCA',
        ),
      ),
    );
