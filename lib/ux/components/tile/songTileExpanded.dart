import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:trackrec_studio/logic/controller/playerController.dart';
import 'package:trackrec_studio/logic/models/modelTrack.dart';
import 'package:trackrec_studio/ux/canvas/SliderShapes/customSliderThumbShape.dart';
import 'package:trackrec_studio/ux/canvas/SliderShapes/customSliderTrackShape.dart';

class SongTileExpanded extends StatefulWidget {
  final String recordLabel;
  final DateTime dateTime;
  final ModelTrack track;
  final VoidCallback onDelete;
  final PlayerController playerController;
  final bool active;
  const SongTileExpanded({ 
    required this.recordLabel, 
    required this.dateTime, 
    required this.track,
    required this.onDelete,
    required this.playerController,
    required this.active,
    Key? key 
  }) : super(key: key);

  @override
  _SongTileExpandedState createState() => _SongTileExpandedState();
}

class _SongTileExpandedState extends State<SongTileExpanded> with TickerProviderStateMixin{
  late AnimationController animationController;
  double seekLower = 0;
  double seekHigher = 0;
  double seekCurrent = 0;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1
    );
    super.initState();
  }

  void changePlayerProps(){
    widget.playerController.playbackStateController.stream.listen((state) {
      if(!widget.active) return;
      if(!mounted) return;
      if(state==PlayerState.isPlaying&&animationController.value!=1){
        animationController.forward();
      }else if((state==PlayerState.isPaused||state==PlayerState.isStopped)&&animationController.value!=0){
        animationController.reverse();
        if(state==PlayerState.isStopped){
          setState(() {
            seekCurrent=seekLower;
          });
        }
      }
    });
    widget.playerController.onChange(
      (duration) {
        if(!widget.active) return;
        if(!mounted) return;
        print("duration came");
        if(seekHigher!=duration.inMilliseconds){
          setState(() {
            seekHigher = duration.inMilliseconds.toDouble();
          });
        }
      }, 
      (duration) {
        if(!widget.active) return;
        if(!mounted) return;
        setState(() {
          seekCurrent = duration.inMilliseconds.toDouble();
        });
      },
    );
  }

  @override
  void didChangeDependencies() {
    if(seekHigher==0)
    changePlayerProps();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.playerController.dispose(soft: true);
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        margin: EdgeInsets.only(bottom: 2,),
        padding: EdgeInsets.only(top: 25),
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 253, 253, 253),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                widget.recordLabel,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                DateFormat('dd-MMM-yyyy').format(widget.dateTime),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 112, 112, 112)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Color.fromARGB(255, 112, 112, 112),
                  thumbColor: Colors.white,
                  inactiveTrackColor: Color.fromARGB(255, 237, 237, 237),
                  thumbShape: CustomSliderThumbShape(
                    disabledThumbRadius: 10
                  ),
                  trackShape: CustomSliderTrackShape()
                ),
                child: Slider(
                  value: seekCurrent, 
                  max: seekHigher,
                  onChanged: (val){
                    widget.playerController.setSeek(Duration(milliseconds: val.toInt()));
                    setState(() {
                      seekCurrent = val;
                    });
                  }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  CupertinoButton(
                    onPressed: () async{
                      if(animationController.value==0){
                        print(seekCurrent!=0&&seekCurrent<seekHigher);
                        if(seekCurrent!=0&&seekCurrent<seekHigher){
                          widget.playerController.resume();
                        }{
                          widget.playerController.play(widget.track.path, ()=>animationController.reverse());
                        }
                      }else{
                        widget.playerController.pause();
                      }
                    }, 
                    child: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: animationController,
                      size: 50,
                      color: Colors.black,
                    )
                  ),
                  CupertinoButton(
                    onPressed: widget.onDelete, 
                    child: Icon(
                      Icons.delete,
                      size: 40,
                      color: Colors.black
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

