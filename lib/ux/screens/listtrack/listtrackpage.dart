import 'package:flutter/material.dart';
import 'package:trackrec_studio/ux/components/appbar/genericAppbar.dart';
import 'package:trackrec_studio/ux/screens/listtrack/components/listRecordTile.dart';
//import 'package:trackrec_studio/ux/screens/listtrack/components/uploadfire.dart';


class Listrack extends StatelessWidget {
  const Listrack({ Key? key }) : super(key: key);

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            body: Column(
              children: [
                GenericAppbar(
                  title: "DONE",
                  ),
                  Expanded(
                  child: ListRecordTile()
                ), 
                //UploadButton(),
              ],
            ),
          );
        }
}