//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecordPanelAppbar extends StatelessWidget {
  final String title;
  final VoidCallback onEnd;
  const RecordPanelAppbar({ Key? key, required this.title, required this.onEnd }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: UnconstrainedBox(
        child: Container(
           decoration: BoxDecoration(
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0,3),
                color: Colors.black.withOpacity(0.02)
              )
            ]
          ),
          alignment: Alignment.topRight,
          width: MediaQuery.of(context).size.width,
          height: 60+MediaQuery.of(context).viewPadding.top,
          padding: EdgeInsets.fromLTRB(28, MediaQuery.of(context).viewPadding.top, 28, 0),
          child: Row(
            children: [
            Navigator.of(context).canPop()? BackButton():Container(),
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              Text(
                title,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900
                ),
              ),

              ElevatedButton(
                child: Text(
                  "", 
                  style: TextStyle(
                    fontSize: 0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w100, 
                  ),
                ), 
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  //fixedSize: Size(160, 50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                onPressed: (){
                  onEnd();
                }
              ),
              

              ElevatedButton(
                child: Text(
                  "SAVE", 
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w900, 
                  ),
                ), 
                style: ElevatedButton.styleFrom(
                  //fixedSize: Size(160, 50),
                  backgroundColor: Colors.yellowAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                onPressed: (){
                  onEnd();
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}