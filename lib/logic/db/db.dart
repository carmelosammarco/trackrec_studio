//import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackrec_studio/logic/enums/FileType.dart';
import 'package:trackrec_studio/logic/helpers/modelRecordHelper.dart';
import 'package:trackrec_studio/logic/helpers/modelTrackHelper.dart';
import 'package:trackrec_studio/logic/models/modelRecord.dart';
import 'package:trackrec_studio/logic/models/modelTrack.dart';

class Db{
  Future<void> init() async{
    await Hive.initFlutter();
    registerAdapters();
    await openAllBox();
  }

  Future<void> openAllBox() async{
    await ModelRecordHelper().openBox();
    await ModelTrackHelper().openBox();
  }

  void registerAdapters(){
    Hive.registerAdapter(ModelTrackAdapter());
    Hive.registerAdapter(ModelRecordAdapter());
    Hive.registerAdapter(FileTypeAdapter());
  }

}