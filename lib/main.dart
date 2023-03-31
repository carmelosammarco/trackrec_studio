import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackrec_studio/logic/context/appContext.dart';
import 'package:trackrec_studio/logic/db/db.dart';
import 'package:trackrec_studio/routes/routeGenerator.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.white, // Color for Android
    statusBarBrightness: Brightness.light //for IOS.
  ));
  await Db().init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      title: 'TrackRec Studio',
      navigatorKey: navigatorState,
      theme: ThemeData(
        primaryColor: Colors.white, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red)
      ),
      initialRoute: "/iniz",
      onGenerateRoute: RouteGenerator.generateRoute
    );
  }
}
