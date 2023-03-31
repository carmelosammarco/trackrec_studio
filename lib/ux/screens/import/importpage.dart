import 'package:flutter/material.dart';
import 'package:trackrec_studio/ux/components/appbar/genericAppbar.dart';
//import 'package:trackrec_studio/ux/screens/home/components/listRecordTile.dart';
import 'package:trackrec_studio/ux/screens/home/components/recordBottomsheet.dart';

class Import extends StatelessWidget {
  const Import({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GenericAppbar(
            title: "IMPORT",
            ),
          RecordBottomsheet()
        ],
      ),
    );
  }
}