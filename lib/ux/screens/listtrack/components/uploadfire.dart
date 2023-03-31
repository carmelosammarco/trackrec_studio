import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: CupertinoColors.activeBlue,
      padding: EdgeInsets.all(10),
      child:Text("UPLOAD!"),
      onPressed: (){

      },
       
    );
    
  }
}