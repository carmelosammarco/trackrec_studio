import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trackrec_studio/logic/enums/FileType.dart';
import 'package:trackrec_studio/logic/enums/RecordTileType.dart';
import 'package:trackrec_studio/logic/models/modelTrack.dart';

class RecordTrackTile extends StatefulWidget {
  final ModelTrack track;
  final int index;
  final VoidCallback onDelete;
  const RecordTrackTile({ 
    Key? key, 
    required this.track,
    required this.index,
    required this.onDelete
  }) : super(key: key);

  @override
  _RecordTrackTileState createState() => _RecordTrackTileState();
}

class _RecordTrackTileState extends State<RecordTrackTile> {
  late Color bgColor;

  @override
  void initState(){
    super.initState();
    bgColor = Color(Random().nextInt(0xffffffff));
  }
  Widget build(BuildContext context) {
      return ListTile( 
        dense: true,
        onLongPress: widget.onDelete,
        onTap: (){
          if(widget.track.fileType==FileType.audio){
            setState(() {
                widget.track.recordType = widget.track.recordType==RecordTileType.Record?
                  RecordTileType.None:
                  RecordTileType.Record;
            });
          }else if(widget.track.fileType==FileType.video){
            setState(() {
                widget.track.recordType = widget.track.recordType==RecordTileType.Display?
                RecordTileType.None:
                RecordTileType.Display;
            });
          }else{
            print("Not recordable audio");
            Fluttertoast.showToast(msg: "The track is not recordable");
          }
        },
        contentPadding: EdgeInsets.fromLTRB(28, 16, 28, 16),
        title: Text(
          widget.track.name,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold
          ),
        ),
        tileColor: bgColor,
        //tileColor: Colors.grey,
        trailing: ((){
          switch (widget.track.recordType) {
            case RecordTileType.None:
              return null;
            case RecordTileType.Display:
              return Image.asset("assets/icon/being display.png", height: 20,);
            case RecordTileType.Record:
              return Image.asset("assets/icon/being record.png", height: 20,);
          }
        }()),
      );
  }
}
