import 'package:flutter/material.dart';
import 'package:trackrec_studio/logic/models/modelRecord.dart';
import 'package:trackrec_studio/ux/iniz/iniz.dart';
import 'package:trackrec_studio/ux/screens/addedSongs/addedSongs.dart';
import 'package:trackrec_studio/ux/screens/home/home.dart';
import 'package:trackrec_studio/ux/screens/import/importpage.dart';
import 'package:trackrec_studio/ux/screens/listtrack/listtrackpage.dart';
import 'package:trackrec_studio/ux/screens/recordPanel/recordPanel.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    switch (settings.name) {

      case '/listrack': //route added 
        return MaterialPageRoute(builder: (_) => Listrack());

      case '/import': //route added 
        return MaterialPageRoute(builder: (_) => Import());

      case '/iniz': //route added 
        return MaterialPageRoute(builder: (_) => Iniz());

      case '/':
        return MaterialPageRoute(builder: (_) => Home());

      case '/added':
        return MaterialPageRoute(builder: (_) => AddedSongs());

      case '/recordPanel':
        if(settings.arguments.runtimeType==ModelRecord){
          final args = settings.arguments as ModelRecord;
          return MaterialPageRoute(builder: (_) => RecordPanel(record: args,));
        }
        return MaterialPageRoute(builder: (_) => RecordPanel());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}