import 'dart:io';
import 'package:chewie/chewie.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trackrec_studio/logic/controller/recordController.dart';
import 'package:trackrec_studio/logic/enums/RecordTileType.dart';
import 'package:trackrec_studio/logic/lib/libRecord.dart';
import 'package:trackrec_studio/logic/models/modelRecord.dart';
import 'package:trackrec_studio/logic/models/modelTrack.dart';
import 'package:trackrec_studio/ux/screens/recordPanel/components/addNewTrackButton.dart';
import 'package:trackrec_studio/ux/screens/recordPanel/components/cancelRecordDialog.dart';
import 'package:trackrec_studio/ux/screens/recordPanel/components/recordPanelAppbar.dart';
import 'package:trackrec_studio/ux/screens/recordPanel/components/recordTrackTile.dart';
//import 'package:video_player/video_player.dart';

class RecordPanel extends StatefulWidget {
  final ModelRecord? record;
  const RecordPanel({ Key? key, this.record }) : super(key: key);

  @override
  _RecordPanelState createState() => _RecordPanelState();
}

class _RecordPanelState extends State<RecordPanel> {
  double sliderValue = 0.0;
  bool didEdit = false;
  late ModelRecord record;
  late ChewieController chewieController;
  //final videoPlayerController = VideoPlayerController.asset('assets/images/butterfly.mp4');

  void che(double val){
    print(val.toString());
    setState(() {
      sliderValue = val;
    });
  }

  @override
  void dispose() {
    // chewieController.dispose();
    //videoPlayerController.dispose();
    record.tracks!.forEach((track) {
      if(!didEdit){
        RecordController().deleteTrackMedia(track, temp: true);
      }
      track.record!.dispose();
    });
    super.dispose();
  }

  @override
  void initState() {
    if(widget.record==null){
      record = ModelRecord(
        name: "TRACK", 
        tracks: [ModelTrack(name: "Layer 1", path: "track_1.aac", milis: 0, recordType: RecordTileType.Record)], 
        exported: false, 
        onCreated: DateTime.now(), 
        onUpdated: DateTime.now()
      );
    }else{
      record = widget.record!;
    }
    LibRecord libRecord = new LibRecord();
    libRecord.init();
    record.tracks![0].record = libRecord;
    // videoPlayerController.initialize().then((value) => videoPlayerController.play());
    // videoPlayerController.addListener(() {
    //   videoPlayerController.position.then((value) => che(value!.inMilliseconds/7544));
    // });

    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   autoPlay: false,
    //   looping: false,
    //   allowFullScreen: false,
    //   showControls: false,
    //   aspectRatio: 16/9
    // );
    // LibRecord.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: !didEdit&&Platform.isIOS? null :() async {
        if(didEdit){
          var status = await CancelRecordDialog.show(
            onSave: (){
              RecordController().saveRecordingPrompt(record, update: widget.record!=null);
            }
          );
          print("status: $status");
          return status;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [ 
            RecordPanelAppbar(
              onEnd: () async{
                if(didEdit){
                  await CancelRecordDialog.show(
                    onSave: (){
                      RecordController().saveRecordingPrompt(record, update: widget.record!=null);
                    }
                  );
                }else{
                  Navigator.of(context).pop();
                }
              },
              title: record.name,
            ), 
            Expanded(
              child: ListView.builder(
                itemCount: record.tracks==null?0:record.tracks!.length,
                padding: EdgeInsets.only(top: 5, bottom: 5),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      ),
                    //padding: const EdgeInsets.only(bottom: 8.0),
                    child: RecordTrackTile(
                      track: record.tracks![index],
                      index: index,
                      onDelete: (){
                        ModelTrack track = record.tracks![index];
                        setState(() {
                          record.tracks!.removeAt(index);
                        });
                        RecordController().deleteTrackMedia(track, temp: true);
                      },
                    ),
                  );
                }
              ),
            ),
            AddNewTrackButton(
              onPlayClick: (play){
                if(!didEdit){
                  setState(() {
                    didEdit = true;
                  });
                }
                return RecordController().onPlaybuttonClicked(play, record);
              },
              addNewTrack: () async{
                var track = ModelTrack(
                  name: "Layer ${record.tracks!.length+1}", 
                  path: "track_${record.tracks!.length+1}.aac", 
                  milis: 0
                );
                track.record = LibRecord();
                await track.record!.init();
                setState(() {
                  record.tracks!.add(track);
                });
              },
              importTrack: (track) async{
                track.record = LibRecord();
                await track.record!.init();
                setState(() {
                  record.tracks!.add(track);
                });
              },
              modelRecord: record,
            ),
          ],
        ),
      ),
    );
  }
}